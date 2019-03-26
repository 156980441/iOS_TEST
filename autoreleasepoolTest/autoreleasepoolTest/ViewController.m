//
//  ViewController.m
//  autoreleasepoolTest
//
//  Created by fanyunlong on 2017/6/27.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ViewController.h"

// http://www.cocoachina.com/ios/20150610/12093.html

@interface ViewController ()

@end

@implementation ViewController

__weak NSString *string_weak_ = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 场景 1
    NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    string_weak_ = string;
    
    // 场景 2
    //    @autoreleasepool {
    //        NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    // 场景 3
    //    NSString *string = nil;
    //    @autoreleasepool {
    //        string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    NSLog(@"string: %@", string_weak_);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string: %@", string_weak_);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"string: %@", string_weak_);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*

 // 场景 1
 2015-05-30 10:32:20.837 AutoreleasePool[33876:1448343] string: leichunfeng
 2015-05-30 10:32:20.838 AutoreleasePool[33876:1448343] string: leichunfeng
 2015-05-30 10:32:20.845 AutoreleasePool[33876:1448343] string: (null)
 // 场景 2
 2015-05-30 10:32:50.548 AutoreleasePool[33915:1448912] string: (null)
 2015-05-30 10:32:50.549 AutoreleasePool[33915:1448912] string: (null)
 2015-05-30 10:32:50.555 AutoreleasePool[33915:1448912] string: (null)
 // 场景 3
 2015-05-30 10:33:07.075 AutoreleasePool[33984:1449418] string: leichunfeng
 2015-05-30 10:33:07.075 AutoreleasePool[33984:1449418] string: (null)
 2015-05-30 10:33:07.094 AutoreleasePool[33984:1449418] string: (null)
 
 */
@end
