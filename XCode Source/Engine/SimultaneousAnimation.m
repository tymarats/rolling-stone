//
//  SimultaneousAnimation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "SimultaneousAnimation.h"

@implementation SimultaneousAnimation

- (id) init {
	if (self = [super init]) {
		parts = [[NSMutableArray alloc] initWithCapacity:2];
	}
	return self;
}

- (void) addPart:(Animation*)part {
	[parts addObject:part];
}

- (void) restart {
	[parts makeObjectsPerformSelector:@selector(restart)];
	[super restart];	
}

- (void) start {
	[super start];
}

- (void) stop {
	[parts makeObjectsPerformSelector:@selector(stop)];
	[super stop];		
}

- (void) cont {
	[parts makeObjectsPerformSelector:@selector(cont)];
	[super cont];		
}

- (void) updateForDelta:(float)delta {
	if (!isRunning)
		return;
	
	float elapsed = MIN((CFAbsoluteTimeGetCurrent() - startTime) * 1000.0 - delay, duration);
	
	if (elapsed < 0)
		return;
	
	BOOL partsFinished = TRUE;
	for (Animation* anim in parts) {
		if (![anim isFinished]) {
			[anim updateForDelta:delta];
			partsFinished = FALSE;
		}
	}
	
	if (partsFinished)
		[self onAnimationEnd];
}

- (void) dealloc {
	[parts removeAllObjects];
	[parts release];
	[super dealloc];
}

@end
