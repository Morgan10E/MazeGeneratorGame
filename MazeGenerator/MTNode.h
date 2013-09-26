//
//  MTNode.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTNode : NSObject

- (id) initWithLocation:(CGPoint)loc;// andParent:(MTNode*)parent andDistance:(double)distance andColor:(UIColor *)color;

- (BOOL) isContainedIn:(NSSet*)cluster;

@property (nonatomic) CGPoint location;

@end
