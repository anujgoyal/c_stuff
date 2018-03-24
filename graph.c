// https://www.geeksforgeeks.org/graph-and-its-representations/
// A C Program to demonstrate adjacency list representation of graphs
// http://www.sanfoundry.com/cpp-programming-examples-graph-problems-algorithms/
 
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

// printgraph: utility function
void printGraph(G* g) {
    int i;
    for(i=0; i<g->V; ++i) {
        ALN* head = g->array[i].head;
        while (head) {
            printf("%i:%i, ", i, head->dest);
            head = head->next;
        }
        printf("\n");
    }
}

// driver program to test above functions
int main() {
    int V = 5;
    G* g = createGraph(V);
    addEdge(g, 0, 1);
    addEdge(g, 0, 4);
    addEdge(g, 1, 2);
    addEdge(g, 1, 3);
    addEdge(g, 1, 4);
    addEdge(g, 2, 3);
    addEdge(g, 3, 4);

    printGraph(g);
    return EXIT_SUCCESS;
}

