/******************************************************************************
 * File: Trailblazer.cpp
 *
 * Implementation of the graph algorithms that comprise the Trailblazer
 * assignment.
 */

#include "Trailblazer.h"
#include "TrailblazerGraphics.h"
#include "TrailblazerTypes.h"
#include "TrailblazerPQueue.h"
#include "hashmap.h"
#include "random.h"

using namespace std;

Grid<Node*> allGray(Grid<double>& world);
bool notAllSeen(Grid<Node *>& nodes);
Vector<Loc> reverse(Vector<Loc>& toReturn);
void deleteAll(Grid<Node *>& nodes);

Node * makeNode(Loc location, Loc nodeParent, double distance, Color c){
    Node * node = new Node;
    node->loc = location;
    node->parent = nodeParent;
    node->dist = distance;
    node->color = c;
    return node;
}

Cluster * makeCluster(Set<Loc>& set){
    Cluster * cluster = new Cluster;
    Set<Edge> edgeSet;
    cluster->locs = set;
    return cluster;
}

/* Function: shortestPath
 * 
 * Finds the shortest path between the locations given by start and end in the
 * specified world.	 The cost of moving from one edge to the next is specified
 * by the given cost function.	The resulting path is then returned as a
 * Vector<Loc> containing the locations to visit in the order in which they
 * would be visited.	If no path is found, this function should report an
 * error.
 *
 * In Part Two of this assignment, you will need to add an additional parameter
 * to this function that represents the heuristic to use while performing the
 * search.  Make sure to update both this implementation prototype and the
 * function prototype in Trailblazer.h.
 */

Vector<Loc>
shortestPath(Loc start,
             Loc end,
             Grid<double>& world,
             double costFn(Loc from, Loc to, Grid<double>& world),
             double heuristic(Loc start, Loc end, Grid<double>& world)){
    //Will store the locations
    //cout<<"Start: "<< start.row << " " << start.col << endl;
    Vector<Loc> toReturn;
    
    //Grid of all the nodes in the map.
    Grid<Node *> nodes = allGray(world);
    
    //The first node, determined by parameters
    Node * startNode = makeNode(start, start, 0, YELLOW);
    colorCell(world, start, YELLOW);
    nodes[start.row][start.col] -> color  = YELLOW;
    
    //Priority queue of the nodes we examine
    TrailblazerPQueue<Node *> nodeQueue;
    //Enqueue the start node
    nodeQueue.enqueue(startNode, heuristic(start, end, world));
    
    while (notAllSeen(nodes)){
        //Find the current node
        Node *curr = nodeQueue.dequeueMin();
        
        //If we're dequeueing it, that means it's the best path and can be finalized. Green.
        curr -> color = GREEN;
        colorCell(world, curr->loc, GREEN);
        nodes[curr->loc.row][curr->loc.col] = curr;
        //If we've reached the end node.
        if (curr->loc == end){
            Loc temp = end;
            while (true){
                toReturn += temp;
                if (temp == start) break;
                temp = curr->parent;
                curr = nodes[temp.row][temp.col];
                //cout << curr->parent.row << endl;
            }
            break;
        }
        
        //Looking at all eight surrounding nodes
        for (int r = -1; r <=1; r++)
            for (int c = -1; c <= 1; c++){
                //don't look at the same node twice
                if (r == 0 && c == 0) continue;
                int newRow = curr->loc.row+c;
                int newCol = curr->loc.col+r;
                
                //don't look at out-of-bounds locations
                if (newRow < 0 || newRow >= world.numRows() || newCol < 0 || newCol >= world.numCols()) continue;

                Loc v = makeLoc(newRow, newCol);
                double newDist = curr -> dist + costFn(curr->loc, v, world);
                
                if (nodes[v.row][v.col]->color == GRAY){
                    colorCell(world, v, YELLOW);
                    Node * newNode = makeNode(v, curr->loc, newDist, YELLOW);
                    nodes[v.row][v.col] = newNode;
                    
                    nodeQueue.enqueue(newNode, newDist + heuristic(v, end, world));
                }
                else{
                    if (nodes[v.row][v.col]->dist > newDist){
                        
                        nodeQueue.decreaseKey(nodes[v.row][v.col], newDist + heuristic(v, end, world));
                        nodes[v.row][v.col]->dist = newDist;
                        nodes[v.row][v.col]->parent = curr -> loc;
                    }
                }
        
            }
        
    }
    //Clean-up
    deleteAll(nodes);
    
    //Reverse the vector so the path is recorded in the right direction
    toReturn = reverse(toReturn);
    
    return toReturn;
}

//Returns the reverse the vector passed as a parameter.
Vector<Loc> reverse(Vector<Loc>& toReturn){
    Vector<Loc> temp;
    for (int i = 1; i <= toReturn.size(); i++){
        Loc loc = toReturn[toReturn.size() - i];
        temp += loc;
    }
    return temp;
}

//Initializes the grid. Sets everything to GRAY.
Grid<Node*> allGray(Grid<double>& world){
    Grid<Node*> unvisited(world.numRows(),world.numCols());
    for (int r = 0; r < world.numRows(); r++)
        for (int c = 0; c < world.numCols(); c++){
            Node * newNode = makeNode(makeLoc(r, c), makeLoc(r, c), world[r][c], GRAY);
            Loc loc = makeLoc(r, c);
            colorCell(world, loc, GRAY);
            unvisited[r][c] = newNode;
        }
    return unvisited;

}

//runs through grid looking for non-finalized nodes (yellow or gray)
bool notAllSeen(Grid<Node *>& nodes){
    for (int r = 0; r < nodes.numRows(); r++)
        for (int c = 0; c < nodes.numCols(); c++)
            if (nodes[r][c] -> color == GRAY || nodes[r][c] -> color == YELLOW)
                return true;
    return false;
}

//Cleans up the grid of nodes - deletes all memory allocation
void deleteAll(Grid<Node *>& nodes){
    for (int r = 0; r < nodes.numRows(); r++)
        for (int c = 0; c < nodes.numCols(); c++)
            delete nodes[r][c];
}

/* Function: createMaze
 *
 * Creates a maze of the specified dimensions using a randomized version of
 * Kruskal's algorithm, then returns a set of all of the edges in the maze.
 *
 * As specified in the assignment handout, the edges you should return here
 * represent the connections between locations in the graph that are passable.
 * Our provided starter code will then use these edges to build up a Grid
 * representation of the maze.
 */
Set<Edge> createMaze(int numRows, int numCols) {
    Set<Edge> mazeSet;
    
    TrailblazerPQueue<Edge> edges;
    Set<Cluster *> clusters;
    
    //Place each node in its own cluster and insert all edges into
    //the priority queue
    for (int r = 0; r < numRows; r++)
        for (int c = 0; c < numCols; c++){
            Set<Loc> locs;
            locs.add(makeLoc(r,c));
            Cluster * cluster = makeCluster(locs);
            clusters.add(cluster);
            
            //if statements ensure all edges in bounds
            if (!(r == numRows-1)){
                Edge edge = makeEdge(makeLoc(r, c), makeLoc(r+1, c));
                edges.enqueue(edge, randomInteger(0, numRows*numCols));
            }
            if (!(c== numCols-1)){
                Edge edge = makeEdge(makeLoc(r,c), makeLoc(r, c+1));
                edges.enqueue(edge, randomInteger(0, numRows*numCols));
            }
        }
    
    
    //until there's only one cluster, and thus one tree
    while (clusters.size()>1){
        Edge edge = edges.dequeueMin();
        Loc one = edge.start;
        Loc two = edge.end;
        
        Cluster *oneCluster;
        Cluster *twoCluster;
        
        //finds the clusters the ends of the edge belong to
        foreach(Cluster *cluster in clusters){
            if (cluster->locs.contains(one))
                oneCluster = cluster;
            if (cluster->locs.contains(two))
                twoCluster = cluster;
        }
        //ignores the edge if they belong in the same cluster
        if (oneCluster == twoCluster)
            continue;
        
        //get rid of old clusters
        clusters.remove(oneCluster);
        clusters.remove(twoCluster);
        
        //merge clusters
        Set<Loc> locs = oneCluster->locs + twoCluster->locs;
        Cluster * newCluster = makeCluster(locs);
        //add new merged cluster
        clusters.add(newCluster);
        //add edge
        mazeSet.add(edge);
    }
    //memory cleanup
    Cluster * toDelete = clusters.first();
    delete toDelete;
    
    return mazeSet;
}

