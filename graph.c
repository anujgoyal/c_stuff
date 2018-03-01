// https://www.geeksforgeeks.org/graph-and-its-representations/
// A C Program to demonstrate adjacency list representation of graphs
 
#include <stdio.h>
#include <stdlib.h>

// stucture to represent an adjacency list node
struct AdjListNode {
  int dest;
  struct AdjListNode* next;
};
typedef struct AdjListNode ALN;

// A structure to represent an adjacency list
struct AdjList {
    ALN *head;  // pointer to head node of list
};
typedef struct AdjList AL;

// A structure to represent a graph. A graph is an array of adjacency lists.
// Size of array will be V (number of vertices in graph)
struct Graph {
    int V;
    AL* array;
};
typedef struct Graph G;

// A utility function to create a new adjacency list node
ALN* newALN(int dest) {
    ALN* newNode = (ALN*) malloc(sizeof(ALN));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

// create a graph of V vertices
G* createGraph(int V) {
    G* g = (G*) malloc(sizeof(G));
    g->V = V;
    g->array = (AL*) calloc(V,sizeof(AL));

    //g->array = (AL*) malloc(V * sizeof(AL));
    //int i;
    //for (i=0; i<V; ++i) {
    //    g->array[i] = (AL)NULL;
    // }
    return g;
}

// add edge to undirected graph
void addEdge(G* g, int src, int dest) {

    // Add edge from src to dest.  A new node is added to the adjacency
    // list of src.  The node is added at the begining O(1)
    // if node was added to end would need to walk linked list; 
    ALN* nn = newALN(dest); // nn: newnode
    nn->next = g->array[src].head;
    g->array[src].head = nn;

    // Since graph is undirected, add an edge from dest to src also
    nn = newALN(src);
    nn->next = g->array[dest].head;
    g->array[dest].head = nn;
}


