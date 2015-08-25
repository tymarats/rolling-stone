//
//  NewtonReactDelegate.h
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactDelegate.h"
#import "OpenGLCommon2.h"

@class Object;

@interface NewtonReactDelegate : NSObject<ReactDelegate> {
	Vector3D d_position;
	Vector3D d_velocity;
	Object* _object;
	CGRect bounds;
	float elasticity;
}

- (id) initWithElasticity:(float)theElasticity
			  boundedBy:(CGRect)theBounds; 

@end
