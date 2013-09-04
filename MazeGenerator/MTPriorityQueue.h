//
//  MTPriorityQueue.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 9/3/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTPriorityQueue : NSMutableArray

- (id) initWithMutableArray:(NSMutableArray *)array;

- (void)createQueueFromMutableArray:(NSMutableArray *)array;

- (id) dequeueMin;

@end
