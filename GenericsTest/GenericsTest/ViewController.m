//
//  ViewController.m
//  GenericsTest
//
//  Created by fanyl on 2018/12/12.
//  Copyright © 2018年 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "Language.h"
#import "Chinese.h"
#import "English.h"
#import "Person.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)test {
    Chinese *c = Chinese.new;
    English *e = English.new;
    
    // 指定这个人会的是 Chinese
    Person<Chinese*> *p = Person.new;
    p.language = c;
    
    // 指定这个人会的是 English
    Person<English *> *p1 = Person.new;
    p1.language = e;
    
}

@end
