//
//  SoundManager.m
//  RollingStone
//
//  Created by Igor Timarac on 11/21/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "SoundManager.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundManager (Private)

- (id) initInstance;

@end


@implementation SoundManager

- (SoundManager*) shaderInstance {
	
	static SoundManager* instance;
	if (!instance) {
		instance = [[SoundManager alloc] initInstance];
	}
	
	return instance;
}

- (id) initInstance {
	if (self = [super init]) {
	}
	return self;
}



@end
