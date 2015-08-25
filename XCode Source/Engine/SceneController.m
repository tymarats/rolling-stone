//
//  SceneController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/16/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Scene.h"
#import "SceneController.h"

@implementation SceneController

@synthesize scene;

- (void) updateForDelta:(float)delta {
	[self processInputs];
	[scene updateForDelta:delta];
	[scene render];
}

- (void) processInputs {
	//NSLog(@"processInputs not implemented!");
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event onView:(UIView*) view {
	//NSLog(@"touchesBegan not implemented!");
}

- (void) dealloc {
	[scene release];
	[super dealloc];
}

@end
