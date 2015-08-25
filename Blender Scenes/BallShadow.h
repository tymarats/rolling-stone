#import "OpenGLCommon.h"


static const TexturedVertexData3D BallshadowVertexData[] = {
	{/*v:*/{1.000000, 1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.527344, 0.779297}},
	{/*v:*/{-1.000000, 1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.593750, 0.779297}},
	{/*v:*/{-1.000000, -1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.593750, 0.712891}},
	{/*v:*/{1.000000, 1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.527344, 0.779297}},
	{/*v:*/{-1.000000, -1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.593750, 0.712891}},
	{/*v:*/{1.000000, -1.000000, 0.000000}, /*n:*/{0.000000, 0.000000, 1.000000}, /*t:*/{0.527344, 0.712891}},
};

#define kBallshadowNumberOfVertices	6
// Drawing Code:
// glEnableClientState(GL_VERTEX_ARRAY);
// glEnableClientState(GL_TEXTURE_COORD_ARRAY);
// glEnableClientState(GL_NORMAL_ARRAY);
// glVertexPointer(3, GL_FLOAT, sizeof(TexturedVertexData3D), &BallshadowVertexData[0].vertex);
// glNormalPointer(GL_FLOAT, sizeof(TexturedVertexData3D), &BallshadowVertexData[0].normal);
// glTexCoordPointer(2, GL_FLOAT, sizeof(TexturedVertexData3D), &BallshadowVertexData[0].texCoord);
// glDrawArrays(GL_TRIANGLES, 0, kBallshadowNumberOfVertices);
// glDisableClientState(GL_VERTEX_ARRAY);
// glDisableClientState(GL_TEXTURE_COORD_ARRAY);
// glDisableClientState(GL_NORMAL_ARRAY);


