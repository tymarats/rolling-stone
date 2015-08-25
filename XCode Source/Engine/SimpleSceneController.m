//
//  SimpleSceneController.m
//  RollingStone
//
//  Created by Igor Timarac on 11/18/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "SimpleSceneController.h"
#import "SimpleScene.h"
#import "Gravity.h"
#import "AccelerometerSimulation.h"
#import "BlenderObject.h"

@implementation SimpleSceneController

- (id) init {
	if (self = [super init]) {
	}
	return self;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	static float alpha = 0.5;
	
	SimpleScene* ms = (SimpleScene*)[self scene];
	Vector3D accel = Vector3DMake(acceleration.x / 1000.0, acceleration.y / 1000.0, 0.0);
	
	ms.gravity.gravityVector = Vector3DAdd(
										   Vector3DScale(accel, alpha), 
										   Vector3DScale(ms.gravity.gravityVector, (1.0-alpha))
										   );
}

- (void) processInputs {
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event onView:(UIView *)view {
	id touch = [touches anyObject];
	SimpleScene* ms = (SimpleScene*)[self scene];
	CGRect sceneBounds = [ms sceneBounds];
	CGRect screenBounds = [ms screenBounds];
	CGPoint loc = [touch locationInView:view];
	float glx = (loc.x / screenBounds.size.width) * sceneBounds.size.width + sceneBounds.origin.x;
	float gly = (loc.y / screenBounds.size.height) * sceneBounds.size.height + sceneBounds.origin.y;
	
	Vector3D v1 = Vector3DMake(glx, -gly, 0.0);
//	Vector3D v2 = Vector3DScale(ms.theObject.position, -1.0);
//	ms.gravity.gravityVector = Vector3DScale(Vector3DAdd(v1, v2), 1/100000.0);
	[[ms gravity] setGravityVector:Vector3DMake(0,0,0)];
	[[ms theObject] setPosition:v1];
}

@end
