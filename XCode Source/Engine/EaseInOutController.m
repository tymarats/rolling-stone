//
//  EaseInOutController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "EaseInOutController.h"
#import "FunctionController.h"

@implementation EaseInOutController

- (float) getValueForArgument:(float)arg {
	float marg = 1.0 - arg;
	return arg <= 0.5 ? arg*arg*arg/0.25 : (1.0 - marg*marg*marg/0.25);
}

@end
