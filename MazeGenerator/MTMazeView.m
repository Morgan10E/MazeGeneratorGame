//
//  MTMazeView.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 9/4/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTMazeView.h"
#import "MTMazeViewController.h"
#import "MTEdge.h"
#import "MTNode.h"

@implementation MTMazeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame andMaze:(NSSet*)maze andController:(MTMazeViewController*)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        _maze = maze;
        _parent = controller;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setBackgroundColor:[UIColor blackColor]];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:40];
    [path setLineCapStyle:kCGLineCapSquare];
    [[UIColor whiteColor] setStroke];
    
    for (MTEdge *edge in _maze){
        [path moveToPoint:[edge start].location];
        [path addLineToPoint:[edge end].location];
        [path stroke];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_parent createNewMaze];
}


@end
