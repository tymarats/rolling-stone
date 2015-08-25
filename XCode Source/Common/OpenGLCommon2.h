/*
 *  OpenGLCommon2.h
 *  RollingStone
 *
 *  Created by Igor Timarac on 11/15/10.
 *  Copyright 2010 CodeNova. All rights reserved.
 *
 */

#include "OpenGLCommon.h"

#define RANDOM_BETWEEN_MINUS1_AND_1() (-1.0 + 2.0*(float)random()/RAND_MAX)

static inline Vector3D CreateRandomVector3D(float xm, float ym, float  zm, float xv, float yv, float zv) {
	Vector3D vec = Vector3DMake(xm, ym, zm);
	vec.x += xv * RANDOM_BETWEEN_MINUS1_AND_1();
	vec.y += yv * RANDOM_BETWEEN_MINUS1_AND_1();
	vec.z += zv * RANDOM_BETWEEN_MINUS1_AND_1();
	return vec;
}

static inline Vector3D Vector3DAdd3(Vector3D v1, Vector3D v2, Vector3D v3) {
	Vector3D vec;
	
	vec.x = v1.x + v2.x + v3.x;
	vec.y = v1.y + v2.y + v3.y;
	vec.z = v1.z + v2.z + v3.z;
	
	return vec;
}

static inline Vector3D Vector3DScale(Vector3D v, float scale) {
	Vector3D vec;
	
	vec.x = scale * v.x;
	vec.y = scale * v.y;
	vec.z = scale * v.z;
	
	return vec;
}

static inline Vector3D Vector3DScale3(Vector3D v, float scaleX, float scaleY, float scaleZ) {
	Vector3D vec;
	
	vec.x = scaleX * v.x;
	vec.y = scaleY * v.y;
	vec.z = scaleZ * v.z;
	
	return vec;
}


static void TestPointWithinBounds(Vector3D point, CGRect bounds, BOOL* up, BOOL *left, BOOL *down, BOOL *right) {
	*left = *right = *up = *down = FALSE;
	if (point.x < bounds.origin.x)
		*left = TRUE;
	if (point.y < bounds.origin.y)
		*up = TRUE;
	if (point.x > bounds.origin.x + bounds.size.width)
		*right = TRUE;
	if (point.y > bounds.origin.y + bounds.size.height)
		*down = TRUE;
}

static Vector3D Vector3DRotateByMatrix(Vector3D v, Matrix3D rot) {
	Vector3D result;
	result.x = rot[0] * v.x + rot[4] * v.y + rot[8] * v.z;
	result.y = rot[1] * v.x + rot[5] * v.y + rot[9] * v.z;
	result.z = rot[2] * v.x + rot[6] * v.y + rot[10] * v.z;
	
	return result;
}

typedef struct {
	GLfloat	x;
	GLfloat y;
	GLfloat z;
	GLfloat w;
} Vector4D;


static Vector4D Vector4DMake(GLfloat x, GLfloat y, GLfloat z, float w) {
	Vector4D v;
	v.x = x;
	v.y = y;
	v.z = z;
	v.w = w;
	return v;
}

