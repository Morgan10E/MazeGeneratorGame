//
//  MTEdge.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTEdge.h"
#import "MTNode.h"

@implementation MTEdge

- (id) initWithStart:(MTNode*)start andEnd:(MTNode*)end
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
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", _start, _end];
}

@end
