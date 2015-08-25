//
//  Object.h
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactDelegate.h"
#import "OpenGLCOmmon2.h"

@interface Object : NSObject {
	Vector3D position;
	Vector3D scale;
	Vector3D velocity;	
	Matrix3D currentRotationMatrix;
	Vector4D tint;
	
	NSObject<ReactDelegate>* reactDelegate;
	
	NSMutableArray* children;	
}

@property (nonatomic, assign) Vector3D position, scale;
@property (nonatomic, assign) Vector3D velocity;
@property (nonatomic, retain) NSObject<ReactDelegate>* reactDelegate;
@property (nonatomic, assign) Vector4D tint;

- (id) initAtPosition:(Vector3D)aPosition velocity:(Vector3D)aVelocity;
- (void) volatileRotateFor:(float)angle around:(Vector3D)axis;
- (void) setOpacity:(float)opacity;
- (void) addChild:(Object*)child;

@end

#import <OpenGLES/EAGL.h>

@interface Object (OpenGL)

- (void) render;
- (void) renderSelf;

@end


