//
//  find132WithMin.c
//  132
//
//  Created by fanyl on 2020/7/31.
//  Copyright © 2020 fanyl. All rights reserved.
//

#include "find132WithMin.h"

bool find132patternWithMin(int* nums, int numsSize) {
    int *min; // 移动游标
    int *pfirst; // 第一个元素指针
    int *plast; // 最后一个元素指针
    
    pfirst = nums;
    plast = nums + numsSize - 1;
    min = pfirst;
    
    while (pfirst < plast) {
        if (*min > *pfirst) {
            min = pfirst; // min
        }
        if (min == pfirst) {
            pfirst++;
            continue;
        }
        int *k = plast;
        while (pfirst < k) {
            if (*min < *k && *k < *pfirst) {
                return true;
            }
            k--;
        }
        pfirst++;
    }
    return false;
}
