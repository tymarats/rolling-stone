//
//  EaseOutController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "EaseOutController.h"


@implementation EaseOutController

- (float) getValueForArgument:(float)arg {
	return arg*arg*arg;
}

@end
