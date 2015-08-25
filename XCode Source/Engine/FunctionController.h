//
//  FunctionController.h
//  RollingStone
//
//  Created by Igor Timarac on 11/23/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionController.h"

@interface FunctionController : NSObject {
	
}

+ (FunctionController*)defaultInstance;

- (float) getValueForArgument:(float)arg; // arg is normalized (0..1)

@end
