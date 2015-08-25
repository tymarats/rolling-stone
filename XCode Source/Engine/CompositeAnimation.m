//
//  CompositeAnimation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "CompositeAnimation.h"
#import "Object.h"

@interface CompositeAnimation (Private)

- (Animation*) restartNextPart;

@end


@implementation CompositeAnimation

- (id) init {
	if (self = [super init]) {
		parts = [[NSMutableArray alloc] initWithCapacity:2];
		currentPartIndex = -1;
	}
	
	return self;
}

- (void) addPart:(Animation *)part {
	[parts addObject:part];
}

- (void) restart {
	[self restartNextPart]; 
	[super restart];	
}

- (void) start {
	[super start];
}

- (void) stop {
	if (current)
		[current stop];
	
	[super stop];		
}

- (void) cont {
	if (current)
		[current cont];
	
	[super cont];		
}

- (void) updateForDelta:(float)delta {
	if (!isRunning)
		return;
	
	float elapsed = MIN((CFAbsoluteTimeGetCurrent() - startTime) * 1000.0 - delay, duration);
	
	if (elapsed < 0)
		return;

	if (!current || [current isFinished])
		current = [self restartNextPart];
	
	if (current)
		[current updateForDelta:delta];
	else 
		[self onAnimationEnd];

}

- (Animation*) restartNextPart {
	currentPartIndex += direction;
	if (currentPartIndex < 0 || currentPartIndex >= [parts count])
		return (current = nil);
	
	current = [parts objectAtIndex:currentPartIndex];
	[current setDirection:direction];
	[current restart];
	
	return current;
}

- (void) dealloc {
	[parts removeAllObjects];
	[parts release];
	[super dealloc];
}

@end
