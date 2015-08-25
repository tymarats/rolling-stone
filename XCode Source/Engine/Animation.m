//
//  Animation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Animation.h"
#import "Object.h"


@implementation Animation

@synthesize duration, delay;
@synthesize fc;

@synthesize loop, backAndForth;
@synthesize isRunning, isFinished;

@synthesize direction;

- (id) init {
	if (self = [super init]) {
		[self setFc:nil];
		[self setDuration:0.0];
		objects = [[NSMutableArray alloc] initWithCapacity:1];
		
		isRunning = FALSE;
		isFinished = FALSE;
		direction = FORWARD;
	}
	return self;	
}


- (id) initForObject:(Object*)o fController:(FunctionController*)c duration:(float)d {
	if (self = [super init]) {
		[self init];
		[self setFc:c];
		[self setDuration:d];
		[self addObject:o];
	}
	return self;
}

- (void) restart {
	startTime = CFAbsoluteTimeGetCurrent();
	isFinished = FALSE;
	isRunning = TRUE;
}

- (void) start {
	if (!isRunning)
		[self restart];
}

- (void) stop {
	isRunning = FALSE;
}

- (void) cont {
	if (!isFinished)
		isRunning = TRUE;
}

- (void) updateForDelta:(float)delta {
	if (!isRunning)
		return;
	
	float elapsed = MIN((CFAbsoluteTimeGetCurrent() - startTime) * 1000.0 - delay, duration);
	
	if (elapsed < 0)
		return;
	
	float arg = (direction == FORWARD) ? elapsed/duration : 1.0 - elapsed/duration;
	float x = [fc getValueForArgument:arg];
	[self animateForArgument:x];
	
	if (elapsed >= duration)
		[self onAnimationEnd];
}

- (void) onAnimationEnd {
	if (backAndForth) {
		direction = -direction;
		if (direction == BACKWARD || loop)
			[self restart]; // don't restart if going forward and not in loop mode
		else {
			isFinished = TRUE;
			[self stop];
		}
	}
	else if (loop) {
		[self restart];
	}
	else {
		isFinished = TRUE;
		[self stop];
	}
}

- (void) addObject:(Object*)o {
	[objects addObject:o];
}

- (void) animateForArgument:(float)argument {
	NSLog(@"Animation function not defined!");
}

- (void) dealloc {
	[objects removeAllObjects];
	[objects release];
	[fc release];
	[super dealloc];
}

@end
