//
//  MTNode.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTNode.h"

@implementation MTNode

- (id) initWithLocation:(CGPoint)loc
{
    self = [super init];
    if (self){
        _location = loc;
    }
    return self;
}

@end
