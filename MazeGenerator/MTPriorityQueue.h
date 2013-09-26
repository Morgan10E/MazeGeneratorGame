//
//  MTPriorityQueue.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 9/3/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTPriorityQueue : NSObject

- (id) initWithMutableArray:(NSMutableArray *)array;

- (void)createQueueFromMutableArray:(NSMutableArray *)array;

- (id) dequeueMin;

@property (nonatomic, strong) NSMutableArray *queue;

@end
