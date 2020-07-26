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
//    int a[] = {0,1,2,0,1,2,0};
    int a[] = {1,2,3,4};
    bool i = find132pattern(a, sizeof(a)/sizeof(int));
    printf("%d", i);
}

bool find132pattern(int* nums, int numsSize) {
    if (numsSize == 0) {
        return false;
    }
    int *curor, *last, tmp;
    
    curor = last = &nums[numsSize - 1]; // 放最后一个
    while (nums < curor) { // 把最后一个放在第二个，第一个是第一个，找到第一个和最后一个中间比最后一个打的
        tmp = *(--curor);
        if (*last < tmp && *nums < tmp && *nums < *last) {
            return true;
        }
        else {
            continue;
        }
    }
    
    last--; // 把倒数第二个当做第二个，第一个是第一个，再次遍历一次
    
    
    while (nums < last) {
        curor = last;
        while (nums < curor) {
            tmp = *(--curor);
            if (*last < tmp && *nums < tmp && *nums < *last) {
                return true;
            }
            else {
                continue;
            }
        }
        last--;
    }
    
    
    
    
    
    curor = nums;
    nums++;
    return find132pattern(nums, numsSize - (int)(nums - curor));
}


@end
