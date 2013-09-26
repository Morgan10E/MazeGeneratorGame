//
//  MTPriorityQueue.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 9/3/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTPriorityQueue.h"

@implementation MTPriorityQueue

- (id) initWithMutableArray:(NSMutableArray *)array
{
    self = [super init];
    if (self){
        _queue = [[NSMutableArray alloc] init];
        [self createQueueFromMutableArray:array];
    }
    return self;
}

- (void)createQueueFromMutableArray:(NSMutableArray *)array
{
    while ([array count] > 0){
        int randomIndex = random()%[array count];
        [_queue addObject:[array objectAtIndex:randomIndex]];
        [array removeObjectAtIndex:randomIndex];
    }
}

- (id) dequeueMin
{
    if ([_queue count]==0)
        return nil;
    id object = [_queue objectAtIndex:0];
    [_queue removeObjectAtIndex:0];
    return object;
}

@end
