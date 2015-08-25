//
//  Sprite.m
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "Sprite.h"
#import "Texture2D.h"
#import "TextureManager.h"

@implementation Sprite

@synthesize texture;

- (id) initWithTexture:(NSString *)aTextureName 
		  spriteBounds:(CGRect)theBounds
			  position:(Vector3D)aPosition
			  velocity:(Vector3D)aVelocity
{
	if (self = [super initAtPosition:aPosition velocity:aVelocity]) {
		spriteBounds = theBounds;
		[self setTexture:[[TextureManager sharedInstance] textureFromFileName:aTextureName]];
		
		// build the vertices and texture coordinates:
		float w2 = theBounds.size.width / 2.0;
		float h2 = theBounds.size.height / 2.0;
		
		float tx0 = theBounds.origin.x / [texture pixelsWide]; 
		float ty0 = theBounds.origin.y / [texture pixelsHigh];
		
		float tx1 = (theBounds.origin.x + theBounds.size.width) / [texture pixelsWide]; 
		float ty1 = (theBounds.origin.y + theBounds.size.height) / [texture pixelsHigh];
	
		vertices[0][0] = -w2; vertices[0][1] = -h2; vertices[0][2] = 0.0;
		vertices[1][0] = w2; vertices[1][1] = h2; vertices[1][2] = 0.0;
		vertices[2][0] = -w2; vertices[2][1] = h2; vertices[2][2] = 0.0;
		 
		vertices[3][0] = -w2; vertices[3][1] = -h2; vertices[3][2] = 0.0;
		vertices[4][0] = w2; vertices[4][1] = -h2; vertices[4][2] = 0.0;
		vertices[5][0] = w2; vertices[5][1] = h2; vertices[5][2] = 0.0;
		 
		// we want to flip texture coordinates vertically, to compensate for the flipped
		// image in bound texture data
		texCoords[0][0] = tx0; texCoords[0][1] = ty1;
		texCoords[1][0] = tx1; texCoords[1][1] = ty0;
		texCoords[2][0] = tx0; texCoords[2][1] = ty0;
		 
		texCoords[3][0] = tx0; texCoords[3][1] = ty1;
		texCoords[4][0] = tx1; texCoords[4][1] = ty1;
		texCoords[5][0] = tx1; texCoords[5][1] = ty0;

	}
	return self;
}

- (void) dealloc {
	[texture release];
	[super dealloc];
}

@end

@implementation Sprite (OpenGL)

- (void) renderSelf {
	glColor4f(tint.x, tint.y, tint.z, tint.w);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
	glNormal3f(0.0, 0.0, 1.0);
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texCoords);
		
	[[TextureManager sharedInstance] bind2DTexture:[texture name]];
	
	glDrawArrays(GL_TRIANGLES, 0, 6);
	
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_VERTEX_ARRAY);
}

@end