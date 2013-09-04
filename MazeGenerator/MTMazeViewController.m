//
//  MTMazeViewController.m
//  MazeGenerator
//
//  Created by Morgan Tenney on 8/27/13.
//  Copyright (c) 2013 Morgan Tenney. All rights reserved.
//

#import "MTMazeViewController.h"
#import "MTCluster.h"
#import "MTNode.h"

@interface MTMazeViewController ()

@end

@implementation MTMazeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSSet*) createMazeWithRows:(int)numRows andColumns:(int)numColumns
{
    //Will contain the edges of the maze
    NSMutableSet *mazeSet = [[NSMutableSet alloc] init];
    
    NSMutableSet *clusters = [[NSMutableSet alloc] init];
    
    //Place each node in its own cluster and insert all edges into
    //the priority queue
    for (int r = 0; r < numRows; r++){
        for (int c = 0; c < numColumns; c++){
            MTCluster *cluster = [[MTCluster alloc] initWithArray:@[[[MTNode alloc] initWithLocation: CGPointMake(r, c)]]];
            [clusters addObject:cluster];
        }
    }
    
    return mazeSet;
}

@end
