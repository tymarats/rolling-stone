//
//  StepController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "StepController.h"

@implementation StepController

@synthesize treshold;

- (id) init {
	return [self initWithTreshold:0.5];
}

- (id) initWithTreshold:(float)theTreshold {
	if (self = [super init]) {
		treshold = theTreshold;
	}
	return self;
}

- (float) getValueForArgument:(float)arg {
	return (float)(arg > treshold);
}

@end
