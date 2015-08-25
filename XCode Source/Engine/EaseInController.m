//
//  EaseInController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "EaseInController.h"


@implementation EaseInController

- (float) getValueForArgument:(float)arg {
	float marg = 1.0 - arg;
	return 1.0 - marg*marg*marg;
	//return sin(arg * M_PI / 2.0); 
}

@end
