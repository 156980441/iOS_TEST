//
//  ViewController.m
//  First2HttpThen1HttpTest
//
//  Created by fanyl on 2019/6/17.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

/**
 
 在开发中很多时候会有这样的场景，同一个界面有多个请求，而且要在这几个请求都成功返回的时候再去进行下一操作，对于这种场景，如何来设计请求操作呢？
 从效率和资源使用的角度来看，testUsingGCDSemaphore 最后一种只使用信号量的方法是最好的，但是却有点使用一个外部变量来保存执行次数的嫌疑。
 **/

static NSString* commandKey = @"key";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testUsingGCDGroup1]; // 【并未达成效果】
//    [self testUsingGCDGroup2]; // 【符合要求】
//    [self testUsingGCDSemaphore];
    [self testUsingGroupEnterLeave];
}

// 模拟一个网络请求方法 get/post/put...etc
- (void)httpRequest:(NSString *)method param:(NSDictionary *)param completion:(void(^)(id response))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *commend = [param objectForKey:commandKey];
        NSLog(@"request:%@ run in thread:%@", commend, [NSThread currentThread]);
        NSTimeInterval sleepInterval = arc4random() % 10;
        [NSThread sleepForTimeInterval:sleepInterval];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"requset:%@ done!", commend);
            block(nil);
        });
    });
}

// 这里的任务是有要求的，这里的任务必须要是同步执行的！！如果任务是异步的，group只会执行完任务里面异步之前的代码以及分发异步任务就返回了！！也就代表分发group的当前这个任务完成了！但事实却是这个任务的一部分子任务在其他线程执行了，而且不一定已执行结束返回。所以现在的解决办法就是把分发到group的任务变成同步执行。

- (void)httpRequest2:(NSString *)method param:(NSDictionary *)param completion:(void(^)(id response))block{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    [self httpRequest:method param:param completion:^(id response) {
        if (block) {
            block(response);
        }
        dispatch_semaphore_signal(sem);
    }];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}


/**
 结果显而易见了，并不是我们想要的那种结果，在这里group的作用只是把你的各个请求都分发出去了，确实是都调了各个请求，但是请求是异步的，调了请求并不代表已经返回结果了，也就是说，group并没有等待异步的请求成功之后才去调用notify，而是调了请求之后就去调用notify，导致请求成功调用在notify之后。
 */
- (void)testUsingGCDGroup1 {
    NSArray *commandArray = @[@"requestcommand1",
                              @"requestcommand2",
                              @"requestcommand3",
                              @"requestcommand4",
                              @"requestcommand5"];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@ in group thread:%@", obj, [NSThread currentThread]);
            [self httpRequest:nil param:@{commandKey : obj} completion:^(id response) {
                
            }];
        });
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all http request done!");
        NSLog(@"UI update in main thread!");
    });
}


/**
 这样的结果就是我们希望得到的了，但是这种方式会使调用的线程数增加了一倍，由原来的5个变成了10个，这是因为我们把请求方法改成了同步的，但是网络请求是在其他线程执行的！系统分配给执行httpRequest2的线程必须等待进行具体网络请求的线程执行结束后再能继续执行，否则继续等待，相对上一种方案来说，这个线程就是刚好多出来的线程，这在上一种方案是不存在的。也就是刚好多了一倍。
 */
- (void)testUsingGCDGroup2 {
    NSArray *commandArray = @[@"requestcommand1",
                              @"requestcommand2",
                              @"requestcommand3",
                              @"requestcommand4",
                              @"requestcommand5"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"%@ in group thread:%@", obj, [NSThread currentThread]);
            [self httpRequest2:nil param:@{commandKey : obj} completion:^(id response) {
                
            }];
        });
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all http request done!");
        NSLog(@"UI update in main thread!");
    });
}


/**
 任务分发线程进行等待，所有网络请求成功返回后才发送信号量，任务分发线程继续执行。
 */
- (void)testUsingGCDSemaphore {
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSArray *commandArray = @[@"requestcommand1",
                              @"requestcommand2",
                              @"requestcommand3",
                              @"requestcommand4",
                              @"requestcommand5"];
    
    NSInteger commandCount = [commandArray count];
    // 代表http访问返回的数量
    // 这里模仿的http请求block块都是在同一线程（主线程）执行返回的，所以对这个变量的访问不存在资源竞争问题，故不需要枷锁处理
    // 如果网络请求在不同线程返回，要对这个变量进行枷锁处理，不然很会有资源竞争危险
    __block NSInteger httpFinishCount = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // demo testUsingSemaphore 方法是在主线程调用的，不直接调用遍历执行，而是嵌套了一个异步，是为了避免主线程阻塞
        NSLog(@"start all http dispatch in thread: %@", [NSThread currentThread]);
        [commandArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self httpRequest:nil param:@{commandKey : obj} completion:^(id response) {
                // 全部请求返回才触发signal
                if (++httpFinishCount == commandCount) {
                    dispatch_semaphore_signal(sem);
                }
            }];
        }];
        // 如果全部请求没有返回则该线程会一直阻塞
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"all http request done! end thread: %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"UI update in main thread!");
        });
    });
    
}

- (void)testUsingGroupEnterLeave {
    NSArray *commandArray = @[@"requestcommand1",
                              @"requestcommand2",
                              @"requestcommand3",
                              @"requestcommand4",
                              @"requestcommand5"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        // demo testUsingGroupEnterLeave 方法是在主线程调用的，不直接调用遍历执行，而是嵌套了一个异步，是为了避免主线程阻塞
        NSLog(@"start all http dispatch in thread: %@", [NSThread currentThread]);
        dispatch_group_enter(group);
        [self httpRequest:nil param:@{commandKey : commandArray[0]} completion:^(id response) {
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        [self httpRequest:nil param:@{commandKey : commandArray[1]} completion:^(id response) {
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        [self httpRequest:nil param:@{commandKey : commandArray[2]} completion:^(id response) {
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        [self httpRequest:nil param:@{commandKey : commandArray[3]} completion:^(id response) {
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        [self httpRequest:nil param:@{commandKey : commandArray[4]} completion:^(id response) {
            dispatch_group_leave(group);
        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // 等待所有 requset 均调用dispatch_group_leave 则进入dispatch_group_notify
            NSLog(@"all http request done!");
            NSLog(@"UI update in main thread!");
        });
        
    });
}

@end
