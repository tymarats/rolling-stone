//
//  FunctionController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "FunctionController.h"

@implementation FunctionController

- (float) getValueForArgument:(float)arg {
	return arg; // simple linear function
}

+ (FunctionController*) defaultInstance {
	static FunctionController *_instance;
	if (!_instance) {
		_instance = [[FunctionController alloc] init];
	}
	return _instance;
}

@end
