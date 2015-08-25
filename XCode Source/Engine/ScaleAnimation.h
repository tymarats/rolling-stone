//
//  ScaleAnimation.h
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"
#import "OpenGLCommon2.h"

@class Object;

@interface ScaleAnimation : Animation {
	Vector3D scale0;
	Vector3D scale1;
	Vector3D dscale;
}

- (id) initForObject:(Object*)o 
		 fController:(FunctionController *)c
			duration:(float)d 
		  startScale:(Vector3D)s0
			endScale:(Vector3D)s1;

@end