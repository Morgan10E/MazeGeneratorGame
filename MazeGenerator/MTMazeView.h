//
//  MTMazeView.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 9/4/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTMazeViewController;

@interface MTMazeView : UIView

- (id) initWithFrame:(CGRect)frame andMaze:(NSSet*)maze andController:(MTMazeViewController*)controller;

@property (nonatomic, weak) MTMazeViewController *parent;
@property (nonatomic, readonly) NSSet *maze;

@end
