//
//  ViewController.m
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "A.h"
#import "Animal.h"
#import "Person.h"
#import "First.h"

// 参考文档：https://www.docin.com/p-1512853530.html

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self advantagesOfDot];
//    [self weaknessOfUnderlineSelf];
    [self weaknessOfUnderlineCrash];
}

- (void)advantagesOfDot {
    First *f = [[First alloc] init];
    [f dotMultithreading];
}

- (void)weaknessOfUnderlineSelf {
    First *f = [[First alloc] init];
    [f underlineMultithreadingSelf];
}

- (void)weaknessOfUnderlineCrash {
    First *f = [[First alloc] init];
    [f underlineMultithreadingWeakSelf];
}

- (void)base {
    A *a = [[A alloc] init];
    //    a->_a; // 报错
        Animal *animal = [[Animal alloc] init];
        [animal setAge:1]; // set
        [animal age]; // get
        
        // dot grammer
        animal.age = 2; // 本质还是调用set方法
        animal.age; // 本质还是调用get方法
        
        // 利用编译器自动生成 getter 和 setter
        Person *p = [[Person alloc] init];
        p.age = 100;
        p.name = @"Tom";
        p.age;
        p.name;
    //    p.sex = @"male"; // 报错
        NSLog(@"weight %f", p.weight);
}


@end
