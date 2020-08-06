//
//  binary_search.c
//  binary_search
//
//  Created by fanyl on 2020/8/6.
//  Copyright © 2020 fanyl. All rights reserved.
//

#include "binary_search.h"

int binaySearch(int const arr[], int const len, int const key) {
    int low = 0; // 定义初始最小
    int high = len-1; // 定义初始最大
    int mid; // 定义中间值
    while (low <= high) {
        mid = (low+high) / 2; // 找中间值，这里自动向下取整
        if (key == arr[mid]) // 判断min与key是否相等
            return mid;
        else if (key > arr[mid]) // 如果key>mid  则新区间为[mid+1,high]
            low = mid + 1;
        else // 如果key<mid  则新区间为[low,mid-1]
            high= mid - 1;
    }
    return -1; // 如果数组中无目标值key，则返回 -1 ；
}
