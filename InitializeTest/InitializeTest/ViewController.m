//
//  ViewController.m
//  InitializeTest
//
//  Created by fanyunlong on 6/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "Father.h"
#import "Children.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Father* f1 = [[Father alloc] init];
    Father* f2 = [[Father alloc] init];
    Father* f3 = [[Father alloc] init];
    
    Children* c1 = [[Children alloc] init];
    Children* c2 = [[Children alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
