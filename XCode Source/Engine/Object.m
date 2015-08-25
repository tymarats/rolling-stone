//
//  Object.m
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Object.h"

@implementation Object

@synthesize position, scale, velocity;
@synthesize reactDelegate;
@synthesize tint;

- (id) initAtPosition:(Vector3D)aPosition velocity:(Vector3D)aVelocity {
	if (self = [super init]) {
		position = aPosition;
		velocity = aVelocity;
		scale = Vector3DMake(1.0, 1.0, 1.0);
		reactDelegate = nil; // reacts to nothing by default
		Matrix3DSetIdentity(currentRotationMatrix);
		tint = Vector4DMake(1.0, 1.0, 1.0, 1.0);		
		children = [[NSMutableArray alloc] initWithCapacity:5];
	}
	
	return self;
}

- (void) setOpacity:(float)opacity {
	tint.w = opacity;
}

- (void) volatileRotateFor:(float)angle around:(Vector3D)axis {
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();
	glRotatef(angle, axis.x, axis.y, axis.z);
	glMultMatrixf(currentRotationMatrix);
	glGetFloatv(GL_MODELVIEW_MATRIX, currentRotationMatrix);
	glPopMatrix();
}

- (void) setReactDelegate:(NSObject <ReactDelegate>*)aReactDelegate {
	if (reactDelegate)
		[reactDelegate release];
	
	reactDelegate = [aReactDelegate retain];
	reactDelegate.object = self;
}

- (void) addChild:(Object *)child {
	[children addObject:child];
}

- (void) dealloc {
	[children removeAllObjects];
	[children release];
	[reactDelegate release];
	[super dealloc];
}

@end

#import <OpenGLES/EAGL.h>

@implementation Object (OpenGL)

- (void) render {
	glMatrixMode(GL_MODELVIEW);	
	glPushMatrix();
	
	glTranslatef(position.x, position.y, position.z);
	glMultMatrixf(currentRotationMatrix);
	glScalef(scale.x, scale.y, scale.z);
	
	[children makeObjectsPerformSelector:@selector(render)];
	[self renderSelf];
	
	glPopMatrix();
}

- (void) renderSelf {
}

@end

