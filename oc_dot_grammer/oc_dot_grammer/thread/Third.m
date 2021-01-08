//
//  Third.m
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import "Third.h"

@implementation Third

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"我是Third的成员变量，使用'_属性'声明";
    }
    return self;
}

- (void)startSelf {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Third %p http start", self);
        sleep(5); // 5秒
        NSLog(@"Third %p name %@", self, self->_name);
        NSLog(@"Third %p http end", self);
        if ([self.delegate respondsToSelector:@selector(finishedThird:)]) {
            [self.delegate finishedThird:self];
        }
    });
}

- (void)startWeakSelf {
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(10);
        __strong typeof(wself) sself = wself;
        NSLog(@"Third %p http start", sself);
        sleep(5); // 5秒
        NSLog(@"Third %p name %@", sself, sself->_name);
        NSLog(@"Third %p http end", sself);
        if ([sself.delegate respondsToSelector:@selector(finishedThird:)]) {
            [sself.delegate finishedThird:sself];
        }
    });
}

- (void)dealloc {
    NSLog(@"Third %p dealloc", self);
}

@end
