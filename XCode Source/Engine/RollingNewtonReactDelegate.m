//
//  RollingNewtonReactDelegate.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "RollingNewtonReactDelegate.h"
#import "Object.h"


@implementation RollingNewtonReactDelegate

- (id) initWithElasticity:(float)theElasticity boundedBy:(CGRect)theBounds radius:(float)aRadius {
	if (self = [super initWithElasticity:theElasticity boundedBy:theBounds]) {
		radius = aRadius; 
	}
	return self;
}

- (void) reactTo:(NSMutableArray *)reactors forDelta:(float)delta {	
	[super reactTo:reactors forDelta:delta];

	float angle = -180.0 / M_PI * (Vector3DMagnitude(d_position) / radius);
	
	Vector3D axis;
	if (fabs(angle) > 0.0001) {
		axis = Vector3DCrossProduct(d_position, Vector3DMake(0.0, 0.0, 1.0));
		Vector3DNormalize(&axis);		
		[_object volatileRotateFor:angle around:axis];
	}		
}

@end


