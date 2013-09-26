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
#import "MTPriorityQueue.h"
#import "MTEdge.h"
#import "MTMazeView.h"

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

- (void)loadView
{
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
    int screenHeight = [[UIScreen mainScreen] bounds].size.height;
    NSSet *maze = [self createMazeWithRows:6 andColumns:9];
    [self setView:[[MTMazeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andMaze:maze andController: self]];
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
    
    NSMutableArray *edgeArray = [[NSMutableArray alloc] init];
    
    //Place each node in its own cluster and insert all edges into
    //the priority queue
    for (int r = 0; r < numRows+1; r++){
        for (int c = 0; c < numColumns+1; c++){
            NSMutableSet *cluster = [[NSMutableSet alloc] initWithObjects:[[MTNode alloc] initWithLocation: CGPointMake(r, c)], nil];
            [clusters addObject:cluster];
            
            //if statements ensure all edges in bounds
            if (!(r == numRows)){
                MTNode *start = [[MTNode alloc] initWithLocation:CGPointMake(r, c)];
                MTNode *end = [[MTNode alloc] initWithLocation:CGPointMake(r+1, c)];
                MTEdge *edge = [[MTEdge alloc] initWithStart:start andEnd:end];
                [edgeArray addObject:edge];
            }
            if (!(c== numColumns)){
                MTNode *start = [[MTNode alloc] initWithLocation:CGPointMake(r, c)];
                MTNode *end = [[MTNode alloc] initWithLocation:CGPointMake(r, c+1)];
                MTEdge *edge = [[MTEdge alloc] initWithStart:start andEnd:end];
                [edgeArray addObject:edge];
            }
        }
    }
    
    MTPriorityQueue *edges = [[MTPriorityQueue alloc] initWithMutableArray:edgeArray];
    
    //until there's only one cluster, and thus one tree
    while ([clusters count]>1){
        MTEdge *edge = [edges dequeueMin];
        MTNode *one = edge.start;
        MTNode *two = edge.end;
        
        NSMutableSet *oneCluster;
        NSMutableSet *twoCluster;
        
        //finds the clusters the ends of the edge belong to
        for (NSMutableSet *cluster in clusters){
            if ([one isContainedIn:cluster])
                oneCluster = cluster;
            if ([two isContainedIn:cluster])
                twoCluster = cluster;
        }
        //ignores the edge if they belong in the same cluster
        if (oneCluster == twoCluster)
            continue;
        
        //get rid of old clusters
        [clusters removeObject:oneCluster];
        [clusters removeObject:twoCluster];
        
        //merge clusters
        NSMutableSet *locs = [[NSMutableSet alloc] initWithSet:oneCluster];
        for (NSMutableSet *cluster in twoCluster){
             [locs addObject:cluster];
        }
        
        //add new merged cluster
        [clusters addObject:locs];
        //add edge
        [mazeSet addObject:edge];
    }
    
    return mazeSet;
}

- (void)createNewMaze
{
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
    int screenHeight = [[UIScreen mainScreen] bounds].size.height;
    NSSet *maze = [self createMazeWithRows:6 andColumns:9];
    [self setView:[[MTMazeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andMaze:maze andController: self]];
}

@end
