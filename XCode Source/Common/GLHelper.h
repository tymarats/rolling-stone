/*
 *  GLHelper.h
 *  RollingStone
 *
 *  Created by Igor Timarac on 11/20/10.
 *  Copyright 2010 CodeNova. All rights reserved.
 *
 */

#import "OpenGLCommon2.h"

static void glhDrawVector(Vector3D origin, Vector3D v, Vector4D color, float length) {
	glPushMatrix();
	glLoadIdentity();
	
	GLfloat points[][3] = {
		{0.0, 0.0, 0.0},
		{v.x, v.y, v.z}
	};
	
	GLfloat colors[][4] = {
		{color.x, color.y, color.z, color.w},
		{color.x, color.y, color.z, color.w}
	};
	
	glTranslatef(origin.x, origin.y, origin.z);
	glScalef(length, length, length);
	BOOL lightingWasEnabled = glIsEnabled(GL_LIGHTING);
	glDisable(GL_LIGHTING);
	glEnable(GL_LINE_SMOOTH);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glLineWidth(1.5);
	glVertexPointer(3, GL_FLOAT, 0, points);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawArrays(GL_LINES, 0, 2);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	if (lightingWasEnabled)
		glEnable(GL_LIGHTING);
	
	glPopMatrix();
}
