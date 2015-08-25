//
//  NewtonReactDelegate.m
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "NewtonReactDelegate.h"
#import "Reactor.h"
#import "Object.h"

@implementation NewtonReactDelegate

@synthesize object=_object;

- (id) initWithElasticity:(float)theElasticity
		   boundedBy:(CGRect)theBounds 
{
	if (self = [super init]) {
		bounds = theBounds;
		elasticity = theElasticity;
		
		d_position = Vector3DMake(0.0, 0.0, 0.0);
		d_velocity = Vector3DMake(0.0, 0.0, 0.0);
	}
	return self;
}

- (void) reactTo:(NSMutableArray *)reactors forDelta:(float)delta {	
	Vector3D accel = Vector3DMake(0.0, 0.0, 0.0);
	
	for (id <Reactor> reactor in reactors)
		accel = Vector3DAdd(accel, [reactor getForceFieldAt:_object.position forObject:_object]);
	
	d_velocity = Vector3DScale(accel, delta);
	d_position = Vector3DAdd(Vector3DScale(_object.velocity, delta), Vector3DScale(accel, delta*delta/2.0));
	
	Vector3D testPosition = Vector3DAdd(_object.position, d_position);
	BOOL up, down, left, right;
	TestPointWithinBounds(testPosition, bounds, &up, &left, &down, &right);
	
	if (up || down) {
		_object.velocity = Vector3DScale3(_object.velocity, 1.0, -elasticity, 1.0);
		d_velocity.y = 0.0;
		d_position.y = 0.0;
	}
	if (left || right) {
		_object.velocity = Vector3DScale3(_object.velocity, -elasticity, 1.0, 1.0);
		d_velocity.x = 0.0;
		d_position.x = 0.0;
	}
	
	_object.position = Vector3DAdd(_object.position, d_position);
	_object.velocity = Vector3DAdd(_object.velocity, d_velocity);
}


@end
