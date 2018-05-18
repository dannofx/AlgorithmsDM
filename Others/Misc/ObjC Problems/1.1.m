//
//  Solution.m
//  Practice
//
//  Created by Danno on 5/9/18.
//  Copyright © 2018 Danno. All rights reserved.
//

#import "Solution.h"

BOOL bitAtIndex(int index, int number) {
    int mask = 1 << index;
    return (number & mask) != 0;
}

void setBitAtIndex(int index, int* number, BOOL value) {
    int mask = 1 << index;
    int nValue = value ? 1 << index : 0;
    *number = (*number & ~mask) | nValue;
}

@interface NSString(Problem)
@property (nonatomic, readonly, getter=hasUniqueCharacters) BOOL hasUniqueCharacters;
@end

@implementation NSString(Problem)
- (BOOL)hasUniqueCharacters {
    NSMutableSet<NSNumber *>* charSet = [[NSMutableSet<NSNumber *> alloc] init];
    for (int i = 0; i < [self length]; i++) {
        int charValue = [self characterAtIndex: i] - 'a';
        NSNumber* charNumber = @(charValue);
        if ([charSet containsObject:charNumber]) {
            return NO;
        } else {
            [charSet addObject:charNumber];
        }
    }
    return YES;
}
//- (BOOL)hasUniqueCharacters {
//    int result = 0;
//    for (int i = 0; i < [self length]; i++) {
//        int charValue = [self characterAtIndex: i] - 'a';
//        BOOL bitValue = bitAtIndex(charValue, result);
//        if (bitValue) {
//            return NO;
//        } else {
//            setBitAtIndex(charValue, &result, YES);
//        }
//    }
//    return YES;
//}
@end

@implementation Solution

- (void)run {
    NSString* example = @"Thi";
    BOOL hasUnique = [example hasUniqueCharacters];
    if (hasUnique) {
        NSLog(@"Is unique");
    } else {
        NSLog(@"Not unique");
    }
}


@end
