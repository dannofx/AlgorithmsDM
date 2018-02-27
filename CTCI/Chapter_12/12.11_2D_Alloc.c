//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// 2D Alloc

#include <stdio.h>
#include <stdlib.h>

int ** alloc2D(int rows, int columns) {
    size_t size_header = rows * sizeof(int *);
    size_t size_row = columns * sizeof(int);
    size_t size_data = rows * size_row;
    int **array = malloc(size_header + size_data);
    if (array == NULL) {
        return NULL;
    }
    for (int i = 0; i < rows; i++) {
        array[i] = ((int *)(array + rows)) + i * columns;
    }
    return array;
}

int main(int argc, const char * argv[]) {
    int rows = 3;
    int columns = 5;
    int ** bid_array = alloc2D(rows, columns);
    if (bid_array == NULL) {
        return -1;
    }
    printf("Testing access:\n");
    for (int row = 0; row < rows; row++) {
        for (int column = 0; column < columns; column++) {
            bid_array[row][columns] = row * columns + column;
            printf("[%02d, %02d]: %02d, ", row, column, bid_array[row][columns]);
        }
        printf("\n");
    }
    free(bid_array);
    return 0;
}

