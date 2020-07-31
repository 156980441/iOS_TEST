//
//  find132WithRecursion.c
//  132
//
//  Created by fanyl on 2020/7/31.
//  Copyright © 2020 fanyl. All rights reserved.
//

#include "find132WithRecursion.h"


bool find132patternRecursion(int* nums, int numsSize) {
    
    if (numsSize == 0) {
        return false;
    }
    
    int *pcuror; // 移动游标
    int *pfirst; // 第一个元素指针
    int *plast; // 最后一个元素指针
    int tmp; // 中间变量
    
    pfirst = nums;
    plast = &nums[numsSize - 1]; // 最后一个元素
    while (pfirst < plast) {
        pcuror = plast;
        while (pfirst < pcuror) { // 第一个是第一个，最后一个放在第二个，之后寻找第一个和最后一个中间比最后一个大的
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
    
    pcuror = pfirst;
    pfirst++;
    return find132patternRecursion(pfirst, numsSize - (int)(pfirst - pcuror));
}
