//
//  ReactDelegate.h
//  RollingStone
//
//  Created by Igor Timarac on 11/22/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Object;

@protocol ReactDelegate

@required

@property(nonatomic, retain) Object* object;
- (void) reactTo:(NSMutableArray*)reactors forDelta:(float)delta;

@end
