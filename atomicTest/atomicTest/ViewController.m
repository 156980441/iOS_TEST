//
//  ViewController.m
//  atomicTest
//
//  Created by fanyunlong on 2017/6/21.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ViewController.h"

/*
 
 简而言之，atomic的作用只是给getter和setter加了个锁，atomic只能保证代码进入getter或者setter函数内部时是安全的，一旦出了getter和setter，多线程安全只能靠程序员自己保障了。所以atomic属性和使用property的多线程安全并没什么直接的联系。另外，atomic由于加锁也会带来一些性能损耗，所以我们在编写iOS代码的时候，一般声明property为nonatomic，在需要做多线程安全的场景，自己去额外加锁做同步。
 
 */

@interface ViewController ()
@property (atomic, assign) int intA;
@property (atomic, strong) NSString* stringA;
@property (nonatomic, strong) NSLock* lock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
}

/*
 
 即使我将 intA 声明为atomic，最后的结果也不一定会是 200000。
 原因就是因为self.intA = self.intA + 1;不是原子操作，虽然intA的getter和setter是原子操作，但当我们使用intA的时候，整个语句并不是原子的，这行赋值的代码至少包含读取(load)，+1(add)，赋值(store)三步操作，当前线程store的时候可能其他线程已经执行了若干次store了，导致最后的值小于预期值。这种场景我们也可以称之为多线程不安全。
 */

- (IBAction)intTest:(id)sender {
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        for (int i = 0; i < 100000; i ++) {
            self.intA = self.intA + 1;
            NSLog(@"Thread A: %d\n", self.intA);
        }
    });
    dispatch_async(q, ^{
        for (int i = 0; i < 100000; i ++) {
            self.intA = self.intA + 1;
            NSLog(@"Thread B: %d\n", self.intA);
        }
    });
}
- (IBAction)memoryTest:(id)sender {
    ///////// 指针Property指向的内存区域不安全例子，会导致崩溃 /////////
    
    /*
     虽然stringA是atomic的property，而且在取substring的时候做了length判断，线程B还是很容易crash，因为在前一刻读length的时候self.stringA = @"a very long string";，下一刻取substring的时候线程A已经将self.stringA = @"string";，立即出现out of bounds的Exception，crash，多线程不安全。
     
     */
    
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        for (int i = 0; i < 100000; i ++) {
            if (i % 2 == 0) {
                self.stringA = @"a very long string";
            }
            else {
                self.stringA = @"string";
            }
            NSLog(@"Thread C: %@\n", self.stringA);
        }
    });
    
    dispatch_async(q, ^{
        for (int i = 0; i < 100000; i ++) {
            if (self.stringA.length >= 10) {
                NSString* subStr = [self.stringA substringWithRange:NSMakeRange(0, 10)];
            }
            NSLog(@"Thread D: %@\n", self.stringA);
        }
    });
}
- (IBAction)memorySafeTest:(id)sender {
    
    /*
     讨论到这里，其实怎么做到多线程安全也比较明朗了，关键字是atomicity（原子性），只要做到原子性，小到一个primitive type变量的访问，大到一长段代码逻辑的执行，原子性能保证代码串行的执行，能保证代码执行到一半的时候，不会有另一个线程介入。
     
     原子性是个相对的概念，它所针对的对象，粒度可大可小。
     
     这也是为什么我们在做多线程安全的时候，并不是通过给property加atomic关键字来保障安全，而是将property声明为nonatomic（nonatomic没有getter，setter的锁开销），然后自己加锁。
     
     */
    
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        [_lock lock];
        for (int i = 0; i < 100000; i ++) {
            if (i % 2 == 0) {
                self.stringA = @"a very long string";
            }
            else {
                self.stringA = @"string";
            }
            NSLog(@"Thread A: %@\n", self.stringA);
        }
        [_lock unlock];
    });
    
    dispatch_async(q, ^{
        [_lock lock];
        if (self.stringA.length >= 10) {
            NSString* subStr = [self.stringA substringWithRange:NSMakeRange(0, 10)];
        }
        [_lock unlock];
        NSLog(@"Thread D: %@\n", self.stringA);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
