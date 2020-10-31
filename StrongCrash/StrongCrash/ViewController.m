//
//  ViewController.m
//  StrongCrash
//
//  Created by fanyl on 2020/10/31.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
// https://www.jianshu.com/p/574f2223ccb0
// https://blog.csdn.net/forwardto9/article/details/81239197

// 使用MRC的思维分析setter方法就可以知道为什么崩溃
/**
 @interface ViewController ()
 @property (retain, atomic) NSObject *obj;
 @end
 @implementation ViewController
 - (void)setObj:(NSObject *)obj {
     @synchronized(objLock) {
         [obj retain];
         [_obj release];
         _obj = obj;
     }
 }
 
 - (NSObject *)obj {
     @synchronized(objLock) {
         [_obj retain];
         [_obj autorelease];
         return _obj;
     }
 }
 @end
 这里立刻 retain +1 然后放到自动释放池，如果直接返回 _obj，那么很可能在外面被释放了，导致 self.obj 不安全。
 假如：
 - (NSObject *)obj {
     @synchronized(objLock) {
         return _obj;
     }
 }
 
 NSObject *obj2 = self.obj;
 ... // 这中间可能释放了obj2
 [obj2 retain];
 obj2...
 
 */
@interface ViewController ()
@property (nonatomic, strong) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self asyncWrite];
}

- (void)asyncWrite {
    for (long long i = 0; i < 1000; i ++) {
        [self performSelectorInBackground:@selector(run) withObject:nil];
    }
}

- (void)run {
    self.name = [NSString stringWithFormat:@"Lily %d", rand()];
    NSLog(@"%@", self.name);
}


@end
