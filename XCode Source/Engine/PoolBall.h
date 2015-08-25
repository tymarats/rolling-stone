//
//  EightBall.h
//  RollingStone
//
//  Created by Igor Timarac on 11/19/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlenderObject.h"

@interface PoolBall : BlenderObject {

}

- (id) initWithElasticity:(float)theElasticity boundedBy:(CGRect)theBounds;

@end
