//
//  StepController.h
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionController.h"

@interface StepController : FunctionController {
	float treshold;
}

@property(nonatomic, assign) float treshold;

- (id) initWithTreshold:(float)theTreshold;

@end
