//
//  Wind.h
//  RollingStone
//
//  Created by Igor Timarac on 11/18/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon2.h"
#import "Reactor.h"

@interface Wind : NSObject <Reactor> {
	float windFactor;
}

@property(nonatomic, assign) float windFactor;

- (id) initWithFactor:(float)aFactor;

@end
