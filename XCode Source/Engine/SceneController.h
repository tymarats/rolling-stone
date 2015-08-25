//
//  SceneController.h
//  RollingStone
//
//  Created by Igor Timarac on 11/16/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Scene;

@interface SceneController : NSObject {
	Scene* scene;
}

@property (nonatomic, retain) Scene* scene;

- (void) updateForDelta:(float)delta;
- (void) processInputs;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event onView:(UIView *)view;

@end
