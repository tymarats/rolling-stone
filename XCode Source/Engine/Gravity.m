//
//  Gravity.m
//  RollingStone
//
//  Created by Igor Timarac on 11/16/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Gravity.h"
#import "Object.h"

@implementation Gravity

@synthesize gravityVector;

- (id) init {
	if (self = [super init])
		gravityVector = Vector3DMake(0.0, -100/1000.0/1000.0, 0.0); // in m/(ms)^2
	return self;
}

- (id) initWithVector:(Vector3D)vector {
	if (self = [super init]) 
		gravityVector = vector;
	return self;
}

- (Vector3D)getForceFieldAt:(Vector3D)position forObject:(Object*)object {
	return gravityVector;
}

@end
