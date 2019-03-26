//
//  ViewController.m
//  GCDTest
//
//  Created by fanyl on 2019/3/25.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

/**
 GCD会自动利用更多的CPU内核（比如双核、四核）。
 GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）。
 程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码。
 参考链接：
 https://www.jianshu.com/p/bc45569adee2
 **/
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self testGroup];
//    [self testBarrier];
//    [self testDelay];
//    [self testIteration];
    
    // 同步测试
//    [self testSyncConCurrent];
//    [self testSyncMain]; // 卡死
//    [self testSyncSerial];
    // 异步测试
//    [self testASyncSerial];
//    [self testAsyncMain];
//    [self testAsynSerial];
    [self testAsynConcurrent];
}

/*
 异步 + 并发 : 会开启新的线程
 如果任务比较多, 那么就会开启多个线程
 */
- (void)testAsynConcurrent
{
    /*
     执行任务
     dispatch_async
     dispatch_sync
     */
    
    /*
     第一个参数: 队列的名称
     第二个参数: 告诉系统需要创建一个并发队列还是串行队列
     DISPATCH_QUEUE_SERIAL :串行
     DISPATCH_QUEUE_CONCURRENT　并发
     */
    
    //    dispatch_queue_t queue = dispatch_queue_create("com.fanyl.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    // 系统内部已经给我们提供好了一个现成的并发队列
    /*
     第一个参数: iOS8以前是优先级, iOS8以后是服务质量
     iOS8以前
     *  - DISPATCH_QUEUE_PRIORITY_HIGH          高优先级 2
     *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      默认的优先级 0
     *  - DISPATCH_QUEUE_PRIORITY_LOW:          低优先级 -2
     *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:
     
     iOS8以后
     *  - QOS_CLASS_USER_INTERACTIVE  0x21 用户交互(用户迫切想执行任务)
     *  - QOS_CLASS_USER_INITIATED    0x19 用户需要
     *  - QOS_CLASS_DEFAULT           0x15 默认
     *  - QOS_CLASS_UTILITY           0x11 工具(低优先级, 苹果推荐将耗时操作放到这种类型的队列中)
     *  - QOS_CLASS_BACKGROUND        0x09 后台
     *  - QOS_CLASS_UNSPECIFIED       0x00 没有设置
     
     第二个参数: 废物
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    /*
     第一个参数: 用于存放任务的队列
     第二个参数: 任务(block)
     
     GCD从队列中取出任务, 遵循FIFO原则 , 先进先出
     输出的结果和苹果所说的原则不符合的原因: CPU可能会先调度其它的线程
     
     能够创建新线程的原因:
     我们是使用"异步"函数调用
     能够创建多个子线程的原因:
     我们的队列是并发队列
     */
    dispatch_async(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    NSLog(@"--------");
}

/*
 异步 +　串行：会开启新的线程
 但是只会开启一个新的线程
 注意: 如果调用 异步函数, 那么不用等到函数中的任务执行完毕, 就会执行后面的代码
 */
- (void)testAsynSerial
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.fanyl.serial", DISPATCH_QUEUE_SERIAL);
    /*
     能够创建新线程的原因:
     我们是使用"异步"函数调用
     只创建1个子线程的原因:
     我们的队列是串行队列
     */
    // 2.将任务添加到队列中
    dispatch_async(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    
    NSLog(@"--------");
}

/*
 异步 + 主队列 : 不会创建新的线程, 并且任务是在主线程中执行
 */
- (void)testAsyncMain
{
    // 主队列:
    // 特点: 只要将任务添加到主队列中, 那么任务"一定"会在主线程中执行 \
    无论你是调用同步函数还是异步函数
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}

/*
 如果是在 子线程 中调用 同步 + 主队列, 那么没有任何问题，不会卡死
 */
- (void)testASyncSerial {
    NSLog(@"%p start", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@" %p start", [NSThread currentThread]);
        dispatch_queue_t queue = dispatch_get_main_queue();
        // 这里卡主子线程了吗？这里子线程会等待主线程执行完之后再往下执行
        dispatch_sync(queue, ^{
            // block 一定会在主线程执行
            NSLog(@"   %@ start", [NSThread currentThread]);
            NSLog(@"   %@ end", [NSThread currentThread]);
        });
        NSLog(@" %p end", [NSThread currentThread]);
    });
    NSLog(@"%p end", [NSThread currentThread]);
}


/*
 同步 + 主队列, 那么会导致死锁
 导致死锁的原因:
 sync 函数是在主线程中执行的, 并且会等待 block 执行完毕. 先调用 block
 block 又是添加到主队列的, 也需要在主线程中执行。
 */
- (void)testSyncMain
{
    NSLog(@"%@", [NSThread currentThread]);
    // 主队列:
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 如果是调用同步函数, 那么会等同步函数中的任务执行完毕, 才会执行后面的代码
    // 注意: 如果dispatch_sync方法是在主线程中调用的, 并且传入的队列是主队列, 那么会导致死锁
    dispatch_sync(queue, ^{
        NSLog(@"----------");
        NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"----------");
}

/*
 同步 + 串行: 不会开启新的线程
 注意点: 如果是调用 同步函数, 那么会等同步函数中的任务执行完毕, 才会执行后面的代码
 */
- (void)testSyncSerial {
    // 1.创建一个串行队列
    // #define DISPATCH_QUEUE_SERIAL NULL
    // 所以可以直接传NULL
    dispatch_queue_t queue = dispatch_queue_create("com.520it.lnj", NULL);
    
    // 2.将任务添加到队列中
    dispatch_sync(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    
    NSLog(@"---------");
}

/*
 同步 + 并发 : 不会开启新的线程，为什么没有卡死？
 */
- (void)testSyncConCurrent
{
    // 1.创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 2.将任务添加到队列中
    dispatch_sync(queue, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2  == %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3  == %@", [NSThread currentThread]);
    });
    
    NSLog(@"---------");
}

- (void)testIteration {
    NSArray *arr = @[@"1", @"2", @"3", @"4"];
    dispatch_apply(arr.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSString *tmp = arr[index];
        NSLog(@"%@ main thread %d : %@", [NSThread currentThread], [NSThread isMainThread], tmp);
    });
}


/**
 3 种方法实现延迟执行
 */
- (void)testDelay {
    // 2秒后再调用self的run方法
    [self performSelector:@selector(p_run_1) withObject:nil afterDelay:2.0];
    
    // 该方法中, 会根据传入的队列来决定回掉 block 在哪个线程中执行
    // 如果传入的是主队列, 那么 block 会在主线程调用
    // 如果传入的是全局队列, 那么 block 会在子线程中调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 这里传入全局队列会在子线程中执行block，如果传入主队列就会在主线程中执行block
        NSLog(@"---- 3s begin-----");
        NSLog(@"3秒之后执行  %@ main thread %d", [NSThread currentThread], [NSThread isMainThread]);
        [NSThread sleepForTimeInterval:3]; // 它会卡住线程
        NSLog(@"---- 3s end -----");
    });
    
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(p_run_2) userInfo:nil repeats:NO];
}

- (void)p_run_1 {
    NSLog(@"---- 2s begin -----");
    NSLog(@"2秒之后执行  %@ main thread %d", [NSThread currentThread], [NSThread isMainThread]);
    [NSThread sleepForTimeInterval:3]; // 它会卡住线程
    NSLog(@"---- 2s end -----");
}

- (void)p_run_2 {
    NSLog(@"---- 4s begin -----");
    NSLog(@"4秒之后执行  %@ main thread %d", [NSThread currentThread], [NSThread isMainThread]);
    [NSThread sleepForTimeInterval:3]; // 它会卡住线程
    NSLog(@"---- 4s end -----");
}

- (void)testCreate {
    // 创建串行队列（队列类型传递NULL或者DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t serial_queue = dispatch_queue_create("serial_queue", NULL);
    dispatch_queue_t concurrent_queue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    // 主队列是 GCD 自带的一种特殊的串行队列
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    // GCD 默认已经提供了全局的并发队列，供整个应用使用，可以无需手动创建。
    dispatch_queue_t global_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

/**
 虽然我们有时要执行几个不同的异步任务，但是我们还是要将其分成两组：当第一组异步任务都执行完成后才执行第二组的异步任务。
 1.如果想要使用栅栏, 那么就不能使用全局的并发队列
 2.如果想使用栅栏, 那么所有的任务都必须添加到同一个队列中
 */
- (void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create("com.fanyl.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 10000; index ++) {
        }
        NSLog(@"完成了任务1");
        
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 20000; index ++) {
        }
        NSLog(@"完成了任务2");
        
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 200000; index ++) {
        }
        NSLog(@"完成了任务3");
        
    });
    
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"--------我是分割线--------");
    });
    
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 400000; index ++) {
        }
        NSLog(@"完成了任务4");
        
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 1000000; index ++) {
        }
        NSLog(@"完成了任务5");
        
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger index = 0; index < 1000; index ++) {
        }
        NSLog(@"完成了任务6");
        
    });
}


/**
 需求点：执行多个耗时的异步任务，但是只能等到这些任务都执行完毕后，才能在主线程执行某个任务。
 缺点：无法指定特定任务优先级
 */
- (void)testGroup {
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 执行1个耗时的异步操作
        for (NSInteger index = 0; index < 10000; index ++) {
        }
        NSLog(@"完成了任务1");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 执行1个耗时的异步操作
        for (NSInteger index = 0; index < 20000; index ++) {
        }
        NSLog(@"完成了任务2");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 执行1个耗时的异步操作
        for (NSInteger index = 0; index < 200000; index ++) {
        }
        NSLog(@"完成了任务3");
        
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 执行1个耗时的异步操作
        for (NSInteger index = 0; index < 400000; index ++) {
        }
        NSLog(@"完成了任务4");
        
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 执行1个耗时的异步操作
        for (NSInteger index = 0; index < 1000000; index ++) {
        }
        NSLog(@"完成了任务5");
        
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        // 等前面的异步操作都执行完毕后，回到主线程...
        NSLog(@"都完成了");
    });
}


@end
