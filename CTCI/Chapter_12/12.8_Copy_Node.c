//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Copy Node

#include <stdio.h>
#include <stdlib.h>

typedef struct _Node {
    struct _Node * left;
    struct _Node * right;
    int value;
} Node;

Node * createNode(int value) {
    Node * node = malloc(sizeof(Node));
    if (node == NULL) {
        return NULL;
    }
    node->value = value;
    return node;
}

Node * copyNode(Node * original) {
    if (original == NULL) {
        return NULL;
    }
    Node * copy = createNode(original->value);
    if(original->left != NULL) {
        copy->left = copyNode(original->left);
    }
    if(original->right != NULL) {
        copy->right = copyNode(original->right);
    }
    return copy;
}

void freeNode(Node * node) {
    if (node != NULL) {
        freeNode(node->left);
        freeNode(node->right);
        free(node);
    }
}

void printNode(Node * node) {
    if (node != NULL) {
        printf("Value: %d\n", node->value);
        printNode(node->left);
        printNode(node->right);
    }
}

int main(int argc, const char * argv[]) {
    Node * original = createNode(5);
    original->left = createNode(1);
    original->right = createNode(10);
    Node * copy = copyNode(original);
    copy->value++;
    if(copy->left != NULL) {
        copy->left->value++;
    }
    if(copy->right != NULL) {
        copy->right->value++;
    }
    printf("Original node:\n");
    printNode(original);
    printf("Copied node:\n");
    printNode(copy);
    freeNode(original);
    freeNode(copy);
    return 0;
}
