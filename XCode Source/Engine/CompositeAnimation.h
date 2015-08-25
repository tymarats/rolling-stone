//
//  CompositeAnimation.h
//  RollingStone
//
//  Created by Igor Timarac on 11/24/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"

@interface CompositeAnimation : Animation {
	NSMutableArray* parts;
	Animation* current;
	
@private
	int currentPartIndex;
}

- (void) addPart:(Animation*)part;

@end
