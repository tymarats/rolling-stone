//
//  Reactor.h
//  RollingStone
//
//  Created by Igor Timarac on 11/16/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLCommon2.h"

@class Object;

@protocol Reactor

- (Vector3D) getForceFieldAt:(Vector3D)position forObject:(Object*)anObject;

@end
