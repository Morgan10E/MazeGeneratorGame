//
//  MTEdge.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTNode;

@interface MTEdge : NSObject

- (id) initWithStart:(MTNode*)start andEnd:(MTNode*)end;

//- (id) initWithStart:(CGPoint)start andEnd:(CGPoint)end;

@property (nonatomic, strong) MTNode *start;
@property (nonatomic, strong) MTNode *end;

//@property (nonatomic) CGPoint start;
//@property (nonatomic) CGPoint end;

@end
