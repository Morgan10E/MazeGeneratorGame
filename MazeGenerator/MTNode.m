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
        int laneWidth = [[UIScreen mainScreen] bounds].size.width/6;
        int x = loc.x*laneWidth;
        int laneHeight = [[UIScreen mainScreen] bounds].size.height/9;
        int y = loc.y*laneHeight;
        _location = CGPointMake(x, y);
    }
    return self;
}

- (BOOL)isContainedIn:(NSSet *)cluster
{
    for (MTNode *node in cluster){
        if ([node location].x == [self location].x && [node location].y == [self location].y)
            return YES;
    }
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<MTNode: (%f,%f)>",[self location].x, [self location].y];
}

@end
