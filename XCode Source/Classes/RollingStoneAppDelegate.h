//
//  RollingStoneAppDelegate.h
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RollingStoneViewController;

@interface RollingStoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RollingStoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RollingStoneViewController *viewController;

@end

