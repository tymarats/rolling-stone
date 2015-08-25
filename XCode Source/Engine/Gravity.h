//
//  Gravity.h
//  RollingStone
//
//  Created by Igor Timarac on 11/16/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reactor.h"
#import "OpenGLCommon2.h"


@interface Gravity : NSObject <Reactor> {
	Vector3D gravityVector;
}

- (id) initWithVector:(Vector3D)vector;

@property(nonatomic, assign) Vector3D gravityVector;

@end
