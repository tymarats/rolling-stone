//
//  RealWorldScene.h
//  RollingStone
//
//  Created by Igor Timarac on 11/15/10.
//  Copyright 2010 CodeNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"
#import "Reactor.h"

@interface RealWorldScene : Scene {
	NSMutableArray *reactorArray;
}

@property (nonatomic, retain) NSMutableArray* reactorArray;

- (int) addReactor:(id <Reactor>)aReactor;

@end
