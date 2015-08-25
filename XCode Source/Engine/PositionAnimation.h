//
//  PositionAnimation.h
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"
#import "OpenGLCommon2.h"

@interface PositionAnimation : Animation {
	Vector3D p0;
	Vector3D p1;
	Vector3D p01;
}

- (id) initForObject:(Object*)o 
		 fController:(FunctionController *)c
			duration:(float)d 
	   startPosition:(Vector3D)pos0
		 endPosition:(Vector3D)pos1;


@end
