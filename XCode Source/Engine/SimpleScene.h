//
//  SimpleScene.h
//  RollingStone
//
//  Created by Igor Timarac on 11/18/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealWorldScene.h"

@class Gravity;
@class Object;

@interface SimpleScene : RealWorldScene {
	Object *theObject;
	Gravity *gravity;
}

@property(nonatomic, retain) Object* theObject;
@property(nonatomic, retain) Gravity* gravity;

@end
