//
//  Scene.m
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Scene.h"
#import "Object.h"
#import "Animation.h"

@implementation Scene

@synthesize screenBounds, sceneBounds;

- (id) init {
	if (self = [super init]) {
		objectArray = [[NSMutableArray alloc] initWithCapacity:10];		
		animationArray = [[NSMutableArray alloc] initWithCapacity:10];
	}
	return self;
}

- (int) addObject:(Object*)anObject {
	[objectArray addObject:anObject];
	return [anObject hash];
}

- (int) addAnimation:(Animation*)anAnimation {
	[animationArray	addObject:anAnimation];
	return [anAnimation hash];
}

- (void) dealloc {
	[objectArray removeAllObjects];
	[objectArray release];
	[animationArray removeAllObjects];
	[animationArray release];
	[super dealloc];
}

- (void) updateForDelta:(float)delta {
	for (Animation* anim in animationArray)
		[anim updateForDelta:delta];
}

@end

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation Scene (OpenGL)

- (void) render {
	glClear(GL_COLOR_BUFFER_BIT);

	[objectArray makeObjectsPerformSelector:@selector(render)];
}

@end
