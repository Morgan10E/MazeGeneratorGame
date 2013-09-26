//
//  MTMazeViewController.h
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMazeViewController : UIViewController

- (NSSet *) createMazeWithRows:(int)rows andColumns:(int)columns;
- (void)createNewMaze;

@end
