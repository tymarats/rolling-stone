//
//  TintAnimation.h
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"
#import "OpenGLCommon2.h"

@interface OpacityAnimation : Animation {
	float alpha0;
	float alpha1;
}

- (id) initForObject:(Object*)o 
		 fController:(FunctionController *)c
			duration:(float)d 
		  startAlpha:(float)a0
			endAlpha:(float)a1;

@end