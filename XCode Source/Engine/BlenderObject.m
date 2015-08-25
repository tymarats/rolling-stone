//
//  BlenderObject.m
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "BlenderObject.h"
#import "GLHelper.h"
#import "TextureManager.h"
	
@implementation BlenderObject

@synthesize texture;
@synthesize isShaded;

- (id) initWithBlenderData:(const VertexData3D[])theData
					 color:(Vector4D)aColor
			   verticesNum:(int)verticesNumber 
				  position:(Vector3D)aPosition
				  velocity:(Vector3D)aVelocity
{
	if (self = [super initAtPosition:aPosition velocity:aVelocity]) {
		data = theData;
		kVerticesNumber = verticesNumber;
		color = aColor;
	}
	
	return self;
}

- (id) initWithTexturedBlenderData:(const TexturedVertexData3D[])theTexturedData
						   texture:(Texture2D*)aTexture
					   verticesNum:(int)verticesNumber 
						  position:(Vector3D)aPosition
						  velocity:(Vector3D)aVelocity
{
	if (self = [super initAtPosition:aPosition velocity:aVelocity]) {
		
		[self setTexture:aTexture];
		texturedData = theTexturedData;
		kVerticesNumber = verticesNumber;
	}
	
	return self;
}

- (void) dealloc {
	[texture release];
	[super dealloc];
}

@end

@implementation BlenderObject (OpenGL)

- (void) renderSelf {	
	// draw vertices list
	
	bool isTextured = texturedData;
	
	const GLvoid* vertexPointer = isTextured ? &texturedData[0].vertex : &data[0].vertex;
	const GLvoid* normalPointer = isTextured ? &texturedData[0].normal : &data[0].normal;
	const GLvoid* texCoordPointer = isTextured ? &texturedData[0].texCoord : NULL;
	
	GLuint stride = isTextured ? sizeof(TexturedVertexData3D) : sizeof(VertexData3D);
	
	if (isShaded) {
		glEnable(GL_LIGHTING);
		glShadeModel(GL_SMOOTH);
	}
	else {
		glDisable(GL_LIGHTING);
	}
	
	if (!isTextured) {
		float mat_ad[] = { color.x, color.y, color.z, color.w }; 
		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, mat_ad);

		float specular[] = { 1.0f, 1.0f, 1.0f, 1.0f }; 
		glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, specular);

		float shininess = 100.0; 
		glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, shininess);
	}
	else {
		glEnable(GL_TEXTURE_2D);
		[[TextureManager sharedInstance] bind2DTexture:[texture name]];
		glBindTexture(GL_TEXTURE_2D, [texture name]);	
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glTexCoordPointer(2, GL_FLOAT, stride, texCoordPointer);
	}
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	
	glVertexPointer(3, GL_FLOAT, stride, vertexPointer);

	glNormalPointer(GL_FLOAT, stride, normalPointer);
	
	glDrawArrays(GL_TRIANGLES, 0, kVerticesNumber);
	
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_LIGHTING);
}


@end
