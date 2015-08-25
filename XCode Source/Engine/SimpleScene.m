//
//  SimpleScene.m
//  RollingStone
//
//  Created by Igor Timarac on 11/18/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TextureManager.h"
#import "SimpleScene.h"
#import "Gravity.h"
#import "Wind.h"
#import "BlenderObject.h"
#import "SmoothBallVertices.h"
#import "GLHelper.h"
#import "Sprite.h"
#import "NewtonReactDelegate.h"
#import "RollingNewtonReactDelegate.h"
#import "FunctionController.h"
#import "PositionAnimation.h"
#import "ScaleAnimation.h"
#import "CompositeAnimation.h"
#import "SimultaneousAnimation.h"
#import "EaseInController.h"
#import "EaseOutController.h"
#import "EaseInOutController.h"
#import "OpacityAnimation.h"
#import "StepController.h"
#import "CosineController.h"

@interface SimpleScene (Private)

- (void) initScene;

@end

@interface SimpleScene (OpenGL)

- (void) initSceneGL;

@end


@implementation SimpleScene

@synthesize theObject, gravity;

- (id) init {
	if (self = [super init]) {
		[self initScene];
		[self initSceneGL];
	}
	
	return self;
}

- (void) initScene {
	screenBounds = [[UIScreen mainScreen] bounds];
	sceneBounds = CGRectMake(-screenBounds.size.width / 2.0,
							 -screenBounds.size.height / 2.0,
							 screenBounds.size.width,
							 screenBounds.size.height);

	Sprite* table = [[Sprite alloc] initWithTexture:@"wood-texture-background-codaxy.jpg"
									   spriteBounds:CGRectMake(0, 0, 500, 324) 
										   position:Vector3DMake(0, 0, 0)
										   velocity:Vector3DMake(0, 0, 0)];
	
	[table volatileRotateFor:-90 around:Vector3DMake(0, 0, 1)];
	[self addObject:table];
	[table release];
	
	Sprite* hole = [[Sprite alloc] initWithTexture:@"game-objects-512.png"
									   spriteBounds:CGRectMake(104, 361, 44, 42) 
										   position:Vector3DMake(80, -80, 0)
										   velocity:Vector3DMake(80, 0, 0)];
	
	[self addObject:hole];
	
	FunctionController *fc = [[EaseInOutController alloc] init];
	
	Animation* anim1 = [[ScaleAnimation alloc] initForObject:hole
												   fController:fc
													  duration:500 
													startScale:Vector3DMake(0,0,1)
													endScale:Vector3DMake(1,1,1)];

	Animation* anim2 = [[PositionAnimation alloc] initForObject:hole
													fController:fc
													   duration:500
												  startPosition:Vector3DMake(80, -80, 0)
													endPosition:Vector3DMake(80, 80, 0)];
	
	Animation* anim3 = [[PositionAnimation alloc] initForObject:hole
													fController:fc
													   duration:500
												  startPosition:Vector3DMake(80, 80, 0)
													endPosition:Vector3DMake(-80, 80, 0)];
	
	Animation* anim4 = [[ScaleAnimation alloc] initForObject:hole
												 fController:fc
													duration:500 
												  startScale:Vector3DMake(1,1,1)
													endScale:Vector3DMake(0,0,0)];
	
	
	CompositeAnimation *anim = [[CompositeAnimation alloc] init];
	
	[anim addPart:anim1];
	[anim addPart:anim2];
	[anim addPart:anim3];
	[anim addPart:anim4];
	
	[anim1 release];
	[anim2 release];
	[anim3 release];
	[anim4 release];
	
	[self addAnimation:anim];
	[anim setBackAndForth:TRUE];
	[anim setLoop:TRUE];
	[anim start];
	[anim release];
	[fc release];
	[hole release];
	
	Sprite* x2 = [[Sprite alloc] initWithTexture:@"game-objects-512.png"
									 spriteBounds:CGRectMake(155, 401, 110, 110) 
										 position:Vector3DMake(0, -180, 0)
										 velocity:Vector3DMake(0, 0, 0)];
	
	Sprite* x2light = [[Sprite alloc] initWithTexture:@"game-objects-512.png"
									 spriteBounds:CGRectMake(267, 401, 110, 110) 
										 position:Vector3DMake(0, -180, 0)
										 velocity:Vector3DMake(0, 0, 0)];
	
	[x2light setOpacity:0.0];
	[self addObject:x2];
	[self addObject:x2light];
	
	Animation* animx2l = [[OpacityAnimation alloc] initForObject:x2light
													 fController:[[[EaseOutController alloc] init] autorelease]
														duration:500 
													  startAlpha:0.0
														endAlpha:1.0];
	[self addAnimation:animx2l];
	[animx2l setDelay:0];
	[animx2l setBackAndForth:TRUE];
	[animx2l setLoop:TRUE];
	[animx2l start];
	
	[animx2l release];
	[x2light release];
	[x2 release];
	
	// ---- 
	// The rest are autoreleased, which does impose some performance penalty, but 
	// I'm getting tired of typing :)
	// ----
	
	
	Texture2D *sixBallTexture = [[[TextureManager sharedInstance] textureFromFileName:@"codaxy.png"] autorelease];
	
	BlenderObject* obj = [[[BlenderObject alloc] initWithTexturedBlenderData:SmoothballVertexData
																	 texture:sixBallTexture
																 verticesNum:kSmoothballNumberOfVertices
																	position:Vector3DMake(0.0, 0.0, 0.0)
																	velocity:Vector3DMake(0.0, 0.0, 0.0)] autorelease];
		
	
	[obj setScale:Vector3DMake(30.0, 30.0, 30.0)];
	[obj setIsShaded:TRUE];
	[obj setPosition:Vector3DMake(0, 64, 0)];
	[obj volatileRotateFor:-90 around:Vector3DMake(1, 0, 0)];
	[obj volatileRotateFor:-70 around:Vector3DMake(0, 1, 0)];
	[self addObject:obj];
	
	RollingNewtonReactDelegate *rnd = [[[RollingNewtonReactDelegate alloc] initWithElasticity:0.6
																					boundedBy:sceneBounds 
																					   radius:40.0] autorelease];
	[obj setReactDelegate:rnd];
	
	
	Sprite* sb = [[[Sprite alloc] initWithTexture:@"game-objects-512.png"
									spriteBounds:CGRectMake(273, 263, 28, 28) 
										position:Vector3DMake(0, 0, 0)
										velocity:Vector3DMake(0, 0, 0)] autorelease];
	
	
	
	
	Animation *scaleAnimate = [[[ScaleAnimation alloc] initForObject:sb 
														 fController:[[[CosineController alloc] init] autorelease]
															duration:500
														  startScale:Vector3DMake(1.2, 0.8, 1.0)
															endScale:Vector3DMake(0.8, 1.2, 1.0)] autorelease];
	[scaleAnimate setLoop:TRUE];
	[scaleAnimate setBackAndForth:TRUE];
	
	
	Sprite* shadow = [[[Sprite alloc] initWithTexture:@"game-objects-512.png"
										spriteBounds:CGRectMake(271, 366, 32, 32) 
											position:Vector3DMake(-6, 0, 0)
											velocity:Vector3DMake(0, 0, 0)] autorelease];
	
	[sb addChild:shadow];
	[self addObject:sb];
	[self setTheObject:sb];

	Animation *shadowAnimate = [[[PositionAnimation alloc] initForObject:shadow 
															 fController:[[[CosineController alloc] init] autorelease]
																duration:1000
														   startPosition:Vector3DMake(-6, -6, 0)
															 endPosition:Vector3DMake(6, -6, 0)] autorelease];
	
	[self addAnimation:scaleAnimate];
	[self addAnimation:shadowAnimate];
	
	[shadowAnimate setLoop:TRUE];
	[shadowAnimate setBackAndForth:TRUE];
	[shadowAnimate start];
	//[scaleAnimate start];
	
	Sprite* newBall = [[[Sprite alloc] initWithTexture:@"0005.png"
										  spriteBounds:CGRectMake(0, 0, 28, 28) 
											  position:Vector3DMake(-40, 0, 0)
											  velocity:Vector3DMake(0, 0, 0)] autorelease];
	
	Sprite* shadow2 = [[[Sprite alloc] initWithTexture:@"shadow.png"
										 spriteBounds:CGRectMake(0, 0, 28, 28) 
											 position:Vector3DMake(-3, -3, 0)
											 velocity:Vector3DMake(0, 0, 0)] autorelease];
	
	[self addObject:newBall];
	[self setTheObject:newBall];	
	[newBall addChild:shadow2];	

	
	
	NewtonReactDelegate *nd = [[[NewtonReactDelegate alloc] initWithElasticity:0.3 boundedBy:sceneBounds] autorelease];
	[sb setReactDelegate:nd];
	
	Gravity *g = [[[Gravity alloc] initWithVector:Vector3DMake(0.0, 0.0, 0.0)] autorelease];
	[self addReactor:g];
	[self setGravity:g];
		
	Wind *w = [[[Wind alloc] initWithFactor:1/10000] autorelease];
	[self addReactor:w];
}

@end

#import <OpenGLES/ES1/gl.h>

@implementation SimpleScene (OpenGL)

- (void) initSceneGL {
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(sceneBounds.origin.x, 
			 sceneBounds.origin.x + sceneBounds.size.width, 
			 sceneBounds.origin.y,
			 sceneBounds.origin.y + sceneBounds.size.height,
			 -64.0, 64.0);
	
	glViewport(screenBounds.origin.x, 
			   screenBounds.origin.y, 
			   screenBounds.size.width, 
			   screenBounds.size.height);

	glEnable(GL_LIGHT0);
	glEnable(GL_NORMALIZE); // TODO: just for test, won't be doing it in production
	
	GLfloat ambientLight[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	GLfloat diffuseLight[] = { 1.0f, 1.0f, 1.0, 1.0f };
	GLfloat position[] = { 0.0, 0.0, 1000.0, 1.0f };
	GLfloat modelAmbient[] = { 1.0, 1.0, 1.0, 1.0 };
	// Assign created components to GL_LIGHT0
	glLightModelfv(GL_LIGHT_MODEL_TWO_SIDE, modelAmbient);
	glLightfv(GL_LIGHT0, GL_AMBIENT, ambientLight);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuseLight);
	glLightfv(GL_LIGHT0, GL_POSITION, position);
	
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);	

	glClearColor(0.0, 0.0, 0.0, 1.0);
}

//- (void) render {
//	[super render];
//	glhDrawVector(Vector3DMake(0,0,0), Vector3DScale(gravity.gravityVector, 1000.0) , Vector4DMake(1.0, 0.0, 0.0, 1.0), 32.0);
//}

- (void) dealloc {
	[theObject release];
	[gravity release];
	[super dealloc];
}

@end
