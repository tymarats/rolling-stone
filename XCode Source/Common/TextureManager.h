//
//  TextureManager.h
//  RollingStone
//
//  Created by Igor Timarac on 11/21/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Texture2D;

@interface TextureManager : NSObject {
	NSMutableDictionary *textures;
	int boundTextureName;
}

+ (TextureManager*) sharedInstance;
- (Texture2D*) textureFromFileName:(NSString *)fileName;

@end


@interface TextureManager (OpenGL)

- (void) bind2DTexture:(int)textureName;

@end