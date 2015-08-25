//
//  RollingNewtonReactDelegate.h
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewtonReactDelegate.h"

@interface RollingNewtonReactDelegate : NewtonReactDelegate {
	float radius;
}

- (id) initWithElasticity:(float)theElasticity
			  boundedBy:(CGRect)theBounds 
				 radius:(float)aRadius;

@end
