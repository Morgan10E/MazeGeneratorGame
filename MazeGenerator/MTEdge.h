//
//  MTEdge.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTEdge : NSObject

- (id) initWithStart:(CGPoint)start andEnd:(CGPoint)end;

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;

@end
