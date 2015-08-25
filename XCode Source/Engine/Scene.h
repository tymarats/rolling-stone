//
//  Scene.h
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>

@class Object;
@class Animation;

@interface Scene : NSObject {
	NSMutableArray *objectArray;
	NSMutableArray *animationArray;
	CGRect sceneBounds;
	CGRect screenBounds;	
}


@property (nonatomic, assign, readonly) CGRect sceneBounds;
@property (nonatomic, assign, readonly) CGRect screenBounds;

- (int) addObject:(Object*)anObject;
- (int) addAnimation:(Animation*)anAnimation;
- (void) updateForDelta:(float)delta;

@end


@interface Scene (OpenGLES)

- (void) render;

@end
