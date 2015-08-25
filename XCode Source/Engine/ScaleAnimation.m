//
//  ScaleAnimation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "ScaleAnimation.h"
#import "Object.h"

@implementation ScaleAnimation

- (id) initForObject:(Object *)o fController:(FunctionController *)c duration:(float)d startScale:(Vector3D)s0 endScale:(Vector3D)s1 {
	if (self = [super initForObject:o fController:c duration:d]) {
		scale0 = s0;
		scale1 = s1;
		dscale = Vector3DAdd(s1, Vector3DScale(s0, -1.0));
	}
	
	return self;
}

- (void) animateForArgument:(float)argument {
	Vector3D s = Vector3DAdd(scale0, Vector3DScale(dscale, argument));
	for (Object* object in objects)
		[object setScale:s]; 
}
@end
