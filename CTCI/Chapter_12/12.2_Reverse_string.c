//
//  Created by Daniel Heredia on 2/27/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

// Reverse string

#include <stdio.h>

void reverse(char * string) {
    if (string == NULL) {
        return;
    }
    char * current = string;
    while (*(++current) != '\0') {}
    current--;
    while (string < current) {
        char temp = *string;
        *string = *current;
        *current = temp;
        string++;
        current--;
    }
}

int main(int argc, const char * argv[]) {
    char string[] = "This is a test string.";
    reverse(string);
    printf("%s \n", string);
    return 0;
}
