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
    
    // 二分法
//    int const arr[] = {1,2,3,4,5,6,7,8,9,10,11}; // 首先要对数组arr进行排序
//    printf("%d \n", binaySearch(arr, (sizeof(arr)/sizeof(arr[0])), 7));
    
    int arr2[] = {3,3,3};
    int returnSize;
    int *arr3 = searchRange(arr2, (sizeof(arr2)/sizeof(arr2[0])), 3, &returnSize);
    for (int i = 0; i < returnSize; i ++) {
        printf("%d,", *(arr3+i));
    }
    free(arr3);
}

int* searchRange(int* nums, int numsSize, int target, int* returnSize)
{
    int arrSize = 0;
    int pre = 0;
    int suf = 0;
    int index = binaySearch(nums, numsSize, target);
    if (index == -1) {
        int *result = malloc(sizeof(int) * 2);
        result[0] = -1;
        result[1] = -1;
        return result;
    }
    else {
        arrSize = 1;
        for (int i = index - 1; i >= 0; i--) {
            if (nums[index] == nums[i]) {
                pre++;
            }
            else {
                break;
            }
        }
        for (int i = index + 1; i < numsSize; i++) {
            if (nums[index] == nums[i]) {
                suf++;
            }
            else {
                break;
            }
        }
        arrSize = arrSize + pre + suf;
        int *result = NULL;
        if (arrSize == 1) {
            result = malloc(sizeof(int) * 2);
            result[0] = index;
            result[1] = index;
            *returnSize = 2;
        }
        else {
//            result = malloc(sizeof(int) * arrSize);
//            int startIndex = index - pre;
//            for (int j = 0; j < arrSize; j ++) {
//                result[j] = startIndex + j;
//            }
//            *returnSize = arrSize;
            result = malloc(sizeof(int) * 2);
            int startIndex = index - pre;
            result[0] = startIndex;
            result[1] = index + suf;
            *returnSize = 2;
        }
        return result;
    }
}


@end
