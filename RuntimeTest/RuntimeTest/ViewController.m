//
//  ViewController.m
//  RuntimeTest
//
//  Created by fanyunlong on 2017/5/26.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
#import <objc/runtime.h>

void breathAdd(id self, SEL _cmd) {
    NSLog(@"Animal breath add");
}

void breathReplace(id self, SEL _cmd) {
    NSLog(@"Animal breath replace");
}

void breathThird(id self, SEL _cmd) {
    NSLog(@"Animal breath third");
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Animal *animal = [[Animal alloc] init];
    [animal breath];
    [animal sleep];
    
    // 替换方法
    class_replaceMethod([Animal class], @selector(breath), (IMP)breathReplace, NULL);
    [animal breath];
    
    // 增加方法
    class_addMethod([Animal class], @selector(breathAdd), (IMP)breathAdd, NULL);
    [animal performSelector:@selector(breathAdd)];
    
    Method method = class_getInstanceMethod([Animal class], @selector(breath));
    method_setImplementation(method, (IMP)breathThird);
    [animal breath];
    
    Method breathMethod = class_getInstanceMethod([Animal class], @selector(breath));
    Method sleepMethod = class_getInstanceMethod([Animal class], @selector(sleep));
    method_exchangeImplementations(breathMethod, sleepMethod);
    [animal breath];
    [animal sleep];
    
    // 增加属性
    animal.name = @"Tom";
    NSLog(@"runtime add property name = %@",animal.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
