//
//  RealWorldScene.m
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import "RealWorldScene.h"
#import "Object.h"
#import "ReactDelegate.h"


@implementation RealWorldScene

@synthesize reactorArray;

- (id) init {
	if (self = [super init]) {
		reactorArray = [[NSMutableArray alloc] initWithCapacity:10];
	}	
	return self;
}

- (int) addReactor:(id)aReactor {
	[reactorArray addObject:aReactor];
	return [aReactor hash];
}

- (void) dealloc {
	[reactorArray removeAllObjects];
	[reactorArray release];
	[super dealloc];
}

- (void) updateForDelta:(float)delta {
	[super updateForDelta:delta];
	for (Object* anObject in objectArray)
		if (anObject.reactDelegate != nil)
			[anObject.reactDelegate reactTo:reactorArray forDelta:delta];			
}

@end
