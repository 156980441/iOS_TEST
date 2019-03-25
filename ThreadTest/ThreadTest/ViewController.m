//
//  ViewController.m
//  ThreadTest
//
//  Created by 赵雪莹 on 2017/4/26.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1:) object:nil];
    thread.name = @"subThread_001";
    [thread start];
    
    [NSThread detachNewThreadSelector:@selector(run2:) toTarget:self withObject:nil]; // 创建并自动启动
    
    [self performSelectorInBackground:@selector(run3:) withObject:nil];
    
    dispatch_queue_t main_queue = dispatch_get_main_queue(); // 串行主队列
    dispatch_queue_t s_queue0 = dispatch_queue_create("tk.bourne.testQueue", NULL); // 串行自定义队列
    dispatch_queue_t s_queue1 = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_SERIAL); // 串行自定义队列
    dispatch_queue_t c_queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT); // 并行自定义队列
    dispatch_queue_t g_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 系统并行队列
    
    /*
     dispatch_sync 后的 block 在主线程执行，也没有卡死主线程，虽然我的 g_queue 是并行队列
     As an optimization, this function invokes the block on the current thread when possible.
     */
    dispatch_sync(g_queue, ^(void){
        NSLog(@"this also execute in main thread ? %d",[NSThread isMainThread]);  // via [NSThread isMainThread]
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
        NSLog(@"%@,%s,is Main %d",[NSThread currentThread].name ,__FUNCTION__,[NSThread isMainThread]);
    }];
    
    //2.开始任务
    [b_operation start];
}

-(void)run1:(id)userdata
{
    NSLog(@"%@,%s",[NSThread currentThread].name ,__FUNCTION__);
}
-(void)run2:(id)userdata
{
    [NSThread currentThread].name = @"subThread_002";
    NSLog(@"%@,%s",[NSThread currentThread].name ,__FUNCTION__);
    
    CFRunLoopRun();
    
    for (int i = 1000; i > 0; i--) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@" --- %d %p",[NSThread isMainThread],[NSThread currentThread]);
        });
    }
    
    
}
-(void)run3:(id)userdata
{
    [NSThread currentThread].name = @"subThread_003";
    NSLog(@"%@,%s",[NSThread currentThread].name ,__FUNCTION__);
}
-(void)run4:(id)userdata
{
    [NSThread currentThread].name = @"subThread_004";
    NSLog(@"%@,%s,is Main %d",[NSThread currentThread].name ,__FUNCTION__,[NSThread isMainThread]);
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
