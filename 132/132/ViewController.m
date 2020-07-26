//
//  ViewController.m
//  132
//
//  Created by fanyl on 2020/7/26.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int a[] = {1,0,1,-4,-3};
    bool i = find132pattern(a, 5);
    printf("%d", i);
}

bool find132pattern(int* nums, int numsSize) {
    if (numsSize == 0) {
        return false;
    }
    int *curor, *last, tmp;
    curor = last = &nums[numsSize - 1];
    while (nums < curor) {
        tmp = *(--curor);
        if (*last < tmp) {
            return true;
        }
        else {
            continue;
        }
    }
    curor = nums;
    nums++;
    return find132pattern(nums, numsSize - (int)(nums - curor));
}


@end
