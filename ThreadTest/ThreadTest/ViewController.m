//
//  ViewController.m
//  ThreadTest
//
//  Created by 赵雪莹 on 2017/4/26.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "ViewController.h"

/**
 进程：
 系统中正在运行的一个程序，进程之间是相互独立的，每个进程都有属于自己的内存空间。
 线程：
 进程内部执行任务所需要的执行路径。
 **/
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 创建一个线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1:) object:nil];
    thread.name = @"subThread_001";
    [thread start];
    
    [NSThread detachNewThreadSelector:@selector(run2:) toTarget:self withObject:nil]; // 创建并自动启动
    
    [self performSelectorInBackground:@selector(run3:) withObject:nil];
    
    
    /**
     GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）。
     程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码。
     GCD会自动利用更多的CPU内核。
     **/
    dispatch_queue_t main_queue = dispatch_get_main_queue(); // 串行主队列
    dispatch_queue_t s_queue0 = dispatch_queue_create("tk.bourne.testQueue", NULL); // 串行自定义队列
    dispatch_queue_t s_queue1 = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_SERIAL); // 串行自定义队列
    dispatch_queue_t c_queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT); // 并行自定义队列
    dispatch_queue_t g_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 系统并行队列
    
    /*
     dispatch_sync 后的 block 在主线程执行，也没有卡死主线程，虽然我的 g_queue 是并行队列，如果是 main_queue 则卡死
     As an optimization, this function invokes the block on the current thread when possible.
     */
    dispatch_sync(g_queue, ^(void){
        NSLog(@"this also execute in main thread ? %d", [NSThread isMainThread]);  // via [NSThread isMainThread]
    });
    
    /*
     优点：
     添加依赖关系
     取消一个正在执行的 operation 、暂停和恢复 operation queue
     支持设置执行的优先级
     支持通过 KVO 来观察 operation 执行状态的变化
     */
    
    //1.创建NSInvocationOperation对象
    NSInvocationOperation *i_operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run4:) object:nil];
    
    //2.开始执行, 默认在当前队列同步执行
    [i_operation start];
    
    //1.创建NSBlockOperation对象
    NSBlockOperation *b_operation = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread currentThread].name = @"subThread_005";
        NSLog(@"main thread ? %d, %@, %s", [NSThread isMainThread], [NSThread currentThread].name , __FUNCTION__);
    }];
    
    //2.开始任务
    [b_operation start];
}

-(void)run1:(id)userdata
{
    NSLog(@"main thread ? %d, %@, %s", [NSThread isMainThread], [NSThread currentThread].name , __FUNCTION__);
}

-(void)run2:(id)userdata
{
    [NSThread currentThread].name = @"subThread_002";
    NSLog(@"main thread ? %d, %@, %s", [NSThread isMainThread], [NSThread currentThread].name , __FUNCTION__);
    
    CFRunLoopRun();
    
    for (int i = 3; i > 0; i--) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"main thread ? %d, %p", [NSThread isMainThread], [NSThread currentThread]);
        });
    }
    
    
}
-(void)run3:(id)userdata
{
    [NSThread currentThread].name = @"subThread_003";
    NSLog(@"main thread ? %d, %@, %s", [NSThread isMainThread], [NSThread currentThread].name , __FUNCTION__);
}

-(void)run4:(id)userdata
{
    [NSThread currentThread].name = @"subThread_004";
    NSLog(@"main thread ? %d, %@, %s", [NSThread isMainThread], [NSThread currentThread].name , __FUNCTION__);
}

-(void)lockMainThread
{
    NSLog(@"before - %@", [NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^(){
        NSLog(@"using - %@", [NSThread currentThread]);
    });
    NSLog(@"after - %@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
