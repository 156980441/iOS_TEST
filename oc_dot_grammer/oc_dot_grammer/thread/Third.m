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
    // 这里把 self 传给 block，让 block 持有 self，等到子线程执行 block 的时候，即使外界已经释放了 self，但该 block 仍然持有 self，使其不会被释放，仍然会正常执行。
    // 不推荐如此使用。因为既然外界已经释放了 self，那么如果继续执行，就会走 delegate，造成不必要的通知甚至崩溃。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 这里子线程休眠，为了让主线程把 self 释放掉
        sleep(10);
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
    // 这里会崩溃，因为外界已经释放了 self，等到该队列执行block的时候，就会因为访问野指针所指的变量而崩溃
    /**
     这里加锁也是不行的，虽然加锁保证了读取，写入时候的串行，但是，当外界将
     lock
     self = nil
     unlock
     子线程还是会因为
     lock
     self->_属性
     unlock
     访问野指针崩溃（注意这里不是多线程写入的崩溃，而是多线程一个线程把对象写入了nil,而另一个线程去读该对象的属性，野指针的崩溃）。
     此时就显示出了 self.属性的优点。因为他其实是调用的getter方法。[nil getter] 是安全的。
     */
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 这里子线程休眠，为了让主线程把 self 释放掉
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
