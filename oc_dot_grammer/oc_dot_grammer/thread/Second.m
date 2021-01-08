//
//  Second.m
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import "Second.h"

@implementation Second

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"我是Second的成员变量，使用@property声明";
    }
    return self;
}

- (void)start {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Second %p http start", self);
        sleep(5); // 5秒
        NSLog(@"Second %p name %@", self, self.name);
        NSLog(@"Second %p http end", self);
        if ([self.delegate respondsToSelector:@selector(finishedSecond:)]) {
            [self.delegate finishedSecond:self];
        }
    });
}

- (void)dealloc {
    NSLog(@"Second %p dealloc", self);
}

@end
