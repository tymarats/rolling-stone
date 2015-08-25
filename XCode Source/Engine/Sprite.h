//
//  Sprite.h
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"
#import "Texture2D.h"
#import "OpenGLCommon2.h"

@interface Sprite : Object {
	Texture2D *texture;	
	CGRect spriteBounds;
	
	float vertices[6][3]; // perhaps we will be using only 4 points, but nevertheless
	float texCoords[6][2];
}

@property(nonatomic, retain) Texture2D* texture;

- (id) initWithTexture:(NSString*)aTextureName 
		  spriteBounds:(CGRect)theBounds
			  position:(Vector3D)position
			  velocity:(Vector3D)velocity;

@end

