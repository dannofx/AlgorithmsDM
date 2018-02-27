//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Malloc

#include <stdio.h>
#include <stdlib.h>

int is_valid_alignment(size_t alignment) {
    if (alignment == 0 || (alignment << 1) == 0) {
        return 0;
    }
    return (alignment & (alignment - 1)) == 0;
}

void aligned_free(void *pointer) {
    void *real_pointer = ((void **)pointer)[-1];
    free(real_pointer);
}
void * align_malloc(size_t requiered_bytes, size_t alignment) {
    if (is_valid_alignment(alignment) == 0) {
        return NULL;
    }
    size_t offset = alignment -1 + sizeof(void *);
    void *real_pointer = malloc(requiered_bytes + offset);
    if (real_pointer == NULL) {
        return NULL;
    }
    void *alg_pointer = (void *)(((size_t)real_pointer + offset) & ~(alignment - 1));
    ((void **)alg_pointer)[-1] = real_pointer;
    return alg_pointer;
}

int main(int argc, const char * argv[]) {
    size_t size = 100;
    size_t alignment = 128;
    void *pointer = align_malloc(size, alignment);
    if (pointer == NULL) {
        return -1;
    }
    unsigned long address = (unsigned long)pointer;
    printf("Address %lu\n", address);
    printf("Is multiple of %lu: %s\n", alignment, (address % alignment) == 0 ? "yes" : "not");
    aligned_free(pointer);
    return 0;
}

