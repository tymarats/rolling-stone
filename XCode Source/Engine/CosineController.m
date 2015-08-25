//
//  CosineController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "CosineController.h"


@implementation CosineController

- (float) getValueForArgument:(float)arg {
	return (1.0 - cos(arg*M_PI)) / 2.0;
}

@end
