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
    g->array = (AL*) malloc(V * sizeof(AL));
    
    int i;
    for (i=0; i<V; ++i) {
        g->array[i] = NULL;
    }
    return g;
}

// add edge to undirected graph
void addEdge(G* g; int src, int dest) {
    // go through linked list and add node to end
    ALN* head = g->array[src].head;
    while(head) {
        head = head->next;
    }
    head  = newALN(dest);
}


