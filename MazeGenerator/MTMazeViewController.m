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
    
    NSMutableArray *edgeArray = [[NSMutableArray alloc] init];
    
    //Place each node in its own cluster and insert all edges into
    //the priority queue
    for (int r = 0; r < numRows; r++){
        for (int c = 0; c < numColumns; c++){
            MTCluster *cluster = [[MTCluster alloc] initWithArray:@[[[MTNode alloc] initWithLocation: CGPointMake(r, c)]]];
            [clusters addObject:cluster];
            
            //if statements ensure all edges in bounds
            if (!(r == numRows-1)){
                MTEdge *edge = [[MTEdge alloc] initWithStart:CGPointMake(r, c) andEnd:CGPointMake(r+1, c)];
                [edgeArray addObject:edge];
            }
            if (!(c== numColumns-1)){
                MTEdge *edge = [[MTEdge alloc] initWithStart:CGPointMake(r, c) andEnd:CGPointMake(r, c+1)];
                [edgeArray addObject:edge];
            }
        }
    }
    
    MTPriorityQueue *edges = [[MTPriorityQueue alloc] initWithMutableArray:edgeArray];
    
    //until there's only one cluster, and thus one tree
    while ([clusters count]>1){
        MTEdge *edge = [edges dequeueMin];
        MTNode *one = [[MTNode alloc] initWithLocation:edge.start];
        MTNode *two = [[MTNode alloc] initWithLocation:edge.end];
        
        MTCluster *oneCluster;
        MTCluster *twoCluster;
        
        //finds the clusters the ends of the edge belong to
        for (MTCluster *cluster in clusters){
            if ([cluster containsObject:one])
                oneCluster = cluster;
            if ([cluster containsObject:two])
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
        for (MTCluster *cluster in twoCluster){
             [locs addObject:cluster];
        }
        MTCluster *newCluster = [[MTCluster alloc] initWithSet:locs];;
        //add new merged cluster
        [clusters addObject:newCluster];
        //add edge
        [mazeSet addObject:edge];
    }
    
    return mazeSet;
}

@end
