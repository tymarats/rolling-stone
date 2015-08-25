//
//  LightTestScene.m
//  RollingStone
//
//  Created by Igor Timarac on 11/21/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "LightTestScene.h"
#import "BlenderObject.h"
#import "SphereRoughVertices.h"
#import "IcoSphereVertices.h"

@interface LightTestScene (Private)

- (void) initScene;

@end

@interface LightTestScene (OpenGL)

- (void) initSceneGL;

@end


@implementation LightTestScene

- (id) init {
	if (self = [super init]) {
		[self initScene];
		[self initSceneGL];
	}
	return self;
}

- (void) initScene {
	screenBounds = [[UIScreen mainScreen] bounds];
	float ratio = screenBounds.size.width / screenBounds.size.height;
	float sceneWidth = 3.0;
	float sceneHeight = sceneWidth / ratio;
	sceneBounds = CGRectMake(-sceneWidth/2.0, -sceneHeight/2.0, sceneWidth, sceneHeight);
	
	BlenderObject* object1 = 
	[[BlenderObject alloc] initWithBlenderData:SphereroughVertexData
											  color:Vector4DMake(1.0, 0.0, 0.0, 1.0)
										verticesNum:kSphereroughNumberOfVertices
										   position:CreateRandomVector3D(0.0, 1.0, 0.0, 0.0*sceneWidth/2.0, 0.0*sceneHeight/2.0, 0.0)
									  velocity:Vector3DMake(0,0,0)];
	
	[object1 setIsShaded:TRUE];
	[object1 volatileRotateFor:RANDOM_BETWEEN_MINUS1_AND_1() * 180.0 around:CreateRandomVector3D(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)];
	[self addObject:object1];
	[object1 release];	

	BlenderObject* object2 = 
	[[BlenderObject alloc] initWithBlenderData:SphereVertexData
											  color:Vector4DMake(1.0, 0.0, 1.0, 1.0)
										verticesNum:kSphereNumberOfVertices
										   position:CreateRandomVector3D(0.0, -1.0, 0.0, 0.0*sceneWidth/2.0, 0.0*sceneHeight/2.0, 0.0)
									  velocity:Vector3DMake(0,0,0)];
	
	
	[object2 setIsShaded:TRUE];
	[object2 volatileRotateFor:RANDOM_BETWEEN_MINUS1_AND_1() * 180.0 around:CreateRandomVector3D(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)];
	[self addObject:object2];
	[object2 release];
}

@end


#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation LightTestScene (OpenGL)

- (void) initSceneGL {
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(sceneBounds.origin.x, 
			 sceneBounds.origin.x + sceneBounds.size.width, 
			 sceneBounds.origin.y,
			 sceneBounds.origin.y + sceneBounds.size.height,
			 -5.0, 5.0);
	
	glViewport(screenBounds.origin.x, 
			   screenBounds.origin.y, 
			   screenBounds.size.width, 
			   screenBounds.size.height);
	
	glEnable(GL_NORMALIZE); // just for test, won't be doing it in production
	
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	
	
	GLfloat ambientLight[] = { 0.0f, 0.0f, 1.0f, 1.0f };
	GLfloat diffuseLight[] = { 0.9f, 0.9f, 0.9f, 1.0f };
	GLfloat specularLight[] = { 0.9f, 0.9f, 0.8f, 1.0f };
	
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuseLight);
	glLightfv(GL_LIGHT0, GL_SPECULAR, specularLight);
	
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);	
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);	
	
	glClearColor(0.0, 0.0, 0.0, 1.0);	
}

@end