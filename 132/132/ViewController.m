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
    int a[] = {-2,1,2,-2,1,2};
    bool i = find132pattern(a, sizeof(a)/sizeof(int));
    printf("%d", i);
}

bool find132pattern(int* nums, int numsSize) {
    
    if (numsSize == 0) {
        return false;
    }
    
    int *pcuror; // 移动游标
    int *plast; // 最后一个元素指针
    int tmp; // 中间变量
    
    plast = &nums[numsSize - 1]; // 最后一个元素
    while (nums < plast) {
        pcuror = plast;
        while (nums < pcuror) { // 第一个是第一个，最后一个放在第二个，之后寻找第一个和最后一个中间比最后一个大的
            --pcuror;
            tmp = *pcuror;
            if (*plast < tmp && *nums < *plast) {
                return true;
            }
            else {
                continue;
            }
        }
        plast--; // 把倒数第二个当做最后个，第一个是第一个，再次遍历一次
    }
    
    pcuror = nums;
    nums++;
    return find132pattern(nums, numsSize - (int)(nums - pcuror));
}


@end
