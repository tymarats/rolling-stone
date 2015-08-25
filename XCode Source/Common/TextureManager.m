//
//  TextureManager.m
//  RollingStone
//
//  Created by Igor Timarac on 11/21/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "TextureManager.h"
#import "Texture2D.h"

@interface TextureManager (Private)

- (id) initInstance;

@end

@implementation TextureManager

+ (TextureManager*) sharedInstance {
	static TextureManager* instance;
	if (!instance) {
		instance = [[TextureManager alloc] initInstance];
	}
	return instance;
}

- (id) initInstance { 
	if (self = [super init]) {
		textures =  [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	return self;
}

- (Texture2D*) textureFromFileName:(NSString*)fileName {
	id t = [textures objectForKey:fileName];
	if (t)
		return (Texture2D*)t;
	
	else {
		// Register new texture under this name:
		UIImage* uiImage = [UIImage imageNamed:fileName];
		Texture2D *t = [[Texture2D alloc] initWithImage:uiImage filter:GL_NEAREST];
		
		[textures setObject:t forKey:fileName];
		
		[uiImage release];
		[t release];
		
		return t;
	}
}

- (void) dealloc {
	[textures release];
	[super dealloc];
}

@end

#import <OpenGLES/EAGL.h>

@implementation TextureManager (OpenGL) 

- (void) bind2DTexture:(int)textureName {
	if (boundTextureName == textureName)
		return;

	glBindTexture(GL_TEXTURE_2D, textureName);
	boundTextureName = textureName;
}

@end