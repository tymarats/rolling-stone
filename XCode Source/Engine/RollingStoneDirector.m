//
//  RollingStoneDirector.m
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "RollingStoneDirector.h"

#import "SimpleScene.h"
#import "SimpleSceneController.h"
#import "LightTestScene.h"

@implementation RollingStoneDirector

@synthesize currentSceneController;

- (id) init {
	if (self = [super init]) {
		isRunning = FALSE;
		lastTime = CFAbsoluteTimeGetCurrent();
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 10.0];
		[[UIAccelerometer sharedAccelerometer] setDelegate:nil];		
		
		//MainScene *scene = [[[MainScene alloc] init] autorelease];
		//MainSceneController *sceneController = [[[MainSceneController alloc] init] autorelease];
		//[sceneController setScene:scene];
		//[self setCurrentSceneController:sceneController];
		
		SimpleScene *simple = [[[SimpleScene alloc] init] autorelease];
		SimpleSceneController *simpleController = [[[SimpleSceneController alloc] init] autorelease];
		[simpleController setScene:simple];
		[self setCurrentSceneController:simpleController];

		//LightTestScene *lts = [[[LightTestScene alloc] init] autorelease];
		//SceneController *sc = [[[SceneController alloc] init] autorelease];
		//[sc setScene:lts];
		//[self setCurrentSceneController:sc];
		
	
	}
	return self;
}

- (void) run {
	isRunning = TRUE;
}

- (void) update {
	if (!isRunning) return;
	
	CFTimeInterval time;
	
	time = CFAbsoluteTimeGetCurrent();
	delta = (time - lastTime) * 1000.0;
	lastTime = time;
	
	if (currentSceneController) {
		[currentSceneController updateForDelta:delta];
	}
}

- (void) stop {
	isRunning = FALSE;
}

- (void) setCurrentSceneController:(SceneController *)sc {
	if (currentSceneController)
		[currentSceneController release];
	
	currentSceneController = [sc retain];
	
	if ([sc conformsToProtocol:@protocol(UIAccelerometerDelegate)])
		[[UIAccelerometer sharedAccelerometer] setDelegate:(SceneController<UIAccelerometerDelegate>*)sc];
	else 
		[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event onView:(UIView*)view{
	[currentSceneController touchesBegan:touches withEvent:event onView:view];
}

- (void) dealloc {
	if (currentSceneController)
		[currentSceneController release];

	[super dealloc];
}

@end
