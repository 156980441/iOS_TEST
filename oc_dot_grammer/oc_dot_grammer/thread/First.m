//
//  First.m
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import "First.h"
#import "Second.h"
#import "Third.h"
@interface First () <SecondDelegate, ThirdDelegate>
{
    Second *_second;
    Third *_third;
}
@end

@implementation First

- (instancetype)init {
    self = [super init];
    if (self) {
        _second = [[Second alloc] init];
        _second.delegate = self;
        _third = [[Third alloc] init];
        _third.delegate = self;
    }
    return self;
}

- (void)dotMultithreading {
    [_second start];
}

- (void)underlineMultithreadingSelf {
    [_third startSelf];
}

- (void)underlineMultithreadingWeakSelf {
    [_third startWeakSelf];
}

- (void)dealloc {
    NSLog(@"First %p dealloc", self);
}

- (void)finishedThird:(Third *)third {
    NSLog(@"First %p, Third %p", self, third);
}

- (void)finishedSecond:(Second *)second {
    NSLog(@"First %p, Second %p", self, second);
}

@end
