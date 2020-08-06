//
//  ViewController.m
//  binary_search
//
//  Created by fanyl on 2020/8/6.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#include "binary_search.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int const arr[] = {1,2,3,4,5,6,7,8,9,10,11}; // 首先要对数组arr进行排序
    printf("%d \n", binaySearch(arr, (sizeof(arr)/sizeof(arr[0])), 7));
}


@end
