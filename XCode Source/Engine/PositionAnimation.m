//
//  PositionAnimation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "PositionAnimation.h"
#import "Object.h"

@implementation PositionAnimation

- (id) initForObject:(Object*)o 
		 fController:(FunctionController *)c
			duration:(float)d 
	   startPosition:(Vector3D)pos0
		 endPosition:(Vector3D)pos1 
{
	if (self = [super initForObject:o fController:c duration:d]) {
		p0 = pos0;
		p1 = pos1;
		
		p01 = Vector3DAdd(pos1, Vector3DScale(pos0, -1.0));
	}
	return self;
}

- (void) animateForArgument:(float)argument {
	Vector3D p = Vector3DAdd(p0, Vector3DScale(p01, argument));
	for (Object* object in objects)
		[object setPosition:p]; 
}

@end
