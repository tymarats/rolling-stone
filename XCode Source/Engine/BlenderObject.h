//
//  BlenderObject.h
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"
#import "OpenGLCommon2.h"
#import "Texture2D.h"

@interface BlenderObject : Object {
	const VertexData3D* data;	
	const TexturedVertexData3D* texturedData;
	int kVerticesNumber;
	Vector4D color;
	Texture2D* texture;
	BOOL isShaded;
}

- (id) initWithBlenderData:(const VertexData3D*)theData 
					 color:(Vector4D)aColor
			   verticesNum:(int)verticesNumber 
				  position:(Vector3D)aPosition
				  velocity:(Vector3D)aVelocity;

- (id) initWithTexturedBlenderData:(const TexturedVertexData3D*)theTexturedData 
						   texture:(Texture2D*)aTexture
					   verticesNum:(int)verticesNumber 
						  position:(Vector3D)aPosition
						  velocity:(Vector3D)aVelocity;


@property(nonatomic, retain) Texture2D* texture;
@property(nonatomic, assign) BOOL isShaded;


@end
