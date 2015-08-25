//
//  Animation.h
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionController.h"

#define FORWARD 1
#define BACKWARD -1

@class Object;

@interface Animation : NSObject {
	NSMutableArray *objects;
	FunctionController *fc;
	float duration;
	
	float delay; // delay for each cycle
	CFTimeInterval startTime;

	BOOL loop;
	BOOL backAndForth;
	
	BOOL isRunning;
	BOOL isFinished;
	
	int direction;
}

@property(nonatomic, retain) FunctionController* fc;
@property(nonatomic, assign) float duration, delay;
@property(nonatomic, assign) BOOL loop;
@property(nonatomic, assign) BOOL backAndForth;
@property(nonatomic, assign, readonly) BOOL isRunning, isFinished;
@property(nonatomic, assign) int direction;

- (id) initForObject:(Object*)o fController:(FunctionController*)c duration:(float)d;
- (void) start;
- (void) restart;
- (void) stop;
- (void) cont;
- (void) updateForDelta:(float)delta;
- (void) addObject:(Object *)o;
- (void) onAnimationEnd;

// Should be overloaded for particular animation
- (void) animateForArgument:(float)argument;

@end
