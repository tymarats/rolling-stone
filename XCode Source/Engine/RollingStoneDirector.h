//
//  RollingStoneDirector.h
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>

@class SceneController;

@interface RollingStoneDirector : NSObject <UIAccelerometerDelegate> {
	SceneController *currentSceneController;
	
	float delta;
	CFTimeInterval lastTime; 
	
	BOOL isRunning;
}

@property (nonatomic, retain) SceneController* currentSceneController;

- (void) run;
- (void) update;
- (void) stop;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event onView:(UIView *)view;

@end
