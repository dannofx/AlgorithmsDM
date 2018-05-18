//
//  Solution.m
//  Practice
//
//  Created by Danno on 5/9/18.
//  Copyright © 2018 Danno. All rights reserved.
//

#import "Solution.h"

typedef void(^CancellableBlock)(BOOL cancel);

@implementation Solution

- (CancellableBlock)dispatchCancellableBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue delay:(CGFloat)delay {
    __block dispatch_block_t originalBlock = [block copy];
    __block CancellableBlock cancellableBlock = ^(BOOL cancel) {
        if (!cancel && originalBlock != nil) {
            originalBlock();
        }
        originalBlock = nil;
        cancellableBlock = nil;
    };
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (cancellableBlock) {
            cancellableBlock(NO);
        }
    });
    return cancellableBlock;
}

- (void)run {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_block_t firstBlock = ^{
        NSLog(@"Won't be executed.");
    };
    dispatch_block_t lastBlock = ^{
        NSLog(@"Block that will be executed.");
    };
    CancellableBlock cancellBlock = [self dispatchCancellableBlock:firstBlock onQueue:queue delay:2.0];
    cancellBlock(YES);
    [self dispatchCancellableBlock:lastBlock onQueue:queue delay:2.0];
    [NSThread sleepForTimeInterval:10.0];
}

@end
