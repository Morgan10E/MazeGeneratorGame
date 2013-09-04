//
//  MTEdge.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTEdge.h"

@implementation MTEdge

- (id) initWithStart:(CGPoint)start andEnd:(CGPoint)end
{
    self = [super init];
    if (self){
        _start = start;
        _end = end;
    }
    return self;
}

- (id) init
{
    return [self initWithStart:CGPointMake(0, 0) andEnd:CGPointMake(0, 0)];
}

@end
