//
//  TintAnimation.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "OpacityAnimation.h"
#import "Object.h"

@implementation OpacityAnimation

- (id) initForObject:(Object*)o 
		 fController:(FunctionController *)c
			duration:(float)d 
		  startAlpha:(float)a0
			endAlpha:(float)a1;
{
	if (self = [super initForObject:o fController:c duration:d]) {
		alpha0 = a0;
		alpha1 = a1;
	}
	return self;
}

- (void) animateForArgument:(float)argument {
	float a = alpha0 + argument*(alpha1 - alpha0);
	for (Object* object in objects)
		[object setOpacity:a]; 
}

@end
