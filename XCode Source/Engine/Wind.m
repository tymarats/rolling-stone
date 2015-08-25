//
//  Wind.m
//  RollingStone
//
//  Created by Igor Timarac on 11/18/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Wind.h"
#import "Object.h"

@implementation Wind

@synthesize windFactor;


- (id) init {
	if (self = [super init])
		windFactor = 0.001;
	return self;
}

- (id) initWithFactor:(float)aFactor {
	if (self = [super init]) {
		windFactor = aFactor;
	}
	return self;
}

- (Vector3D) getForceFieldAt:(Vector3D)position forObject:(Object*)object {
	return Vector3DScale(object.velocity, -windFactor);
}

@end
