//
//  EightBall.m
//  RollingStone
//
//  Created by Igor Timarac on 11/19/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "PoolBall.h"
#import "OpenGLCommon2.h"
#import "SmoothBallVertices.h"
#import "Texture2D.h"
#import "TextureManager.h"

@implementation PoolBall

- (id) initWithElasticity:(float)theElasticity boundedBy:(CGRect)theBounds {
	if (self = [super initWithTexturedBlenderData:SmoothballVertexData
										  texture:nil
									  verticesNum:kSmoothballNumberOfVertices
										 position:Vector3DMake(0.0, 0.0, 0.0)
										 velocity:Vector3DMake(0.0, 0.0, 0.0)]) {
		
		
		Texture2D *t = [[TextureManager sharedInstance] textureFromFileName:@"6.png"];
		[self setTexture:t];
	}
	return self;
}

@end
