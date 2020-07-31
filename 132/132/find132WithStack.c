//
//  find132WithStack.c
//  132
//
//  Created by fanyl on 2020/7/29.
//  Copyright © 2020 fanyl. All rights reserved.
//

#include "find132WithStack.h"
#include "stack.h"
#include <limits.h>

bool find132patternStack(int* nums, int numsSize) {
    int s3 = INT_MIN;
    Stack s2;
    initStack(&s2);
    for(int i = numsSize-1; i>=0; i--){
        if(s3 > nums[i]){
            return true;
        }
        Element e = INT_MAX;
        if (!emptyStack(&s2)) {
            topStack(&s2, &e);
        }
        while(!emptyStack(&s2) && nums[i] > e){
            s3 = e;
            popStack(&s2, &e);
            topStack(&s2, &e);
        }
        pushStack(&s2, nums[i]);
    }
    return false;
}
