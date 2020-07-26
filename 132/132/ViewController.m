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

void chars2IntArr (const char* str, int *output, unsigned int length) {
    for (int i = 0; i < length; i++) {
        output[i] = atoi(&str[i * 2]);
    }
    
    printf("\n======\n");
    
    for (int i = 0; i < length; i++) {
        printf("%d,", output[i]);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取视频播放路径
    NSString *str = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [NSString stringWithFormat:@"%@%@", str, @"/132_test.txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    const char *cStr = dataStr.UTF8String;
    size_t num = strlen(cStr);
    NSLog(@"%s", cStr);
    
    size_t num2 = ceil(strlen(cStr) / 2);
    int *arr = malloc(sizeof(int) * num2);
    chars2IntArr(cStr, arr, (unsigned int)num2);
    
    // Do any additional setup after loading the view.
    //    int a[] = {0,1,2,0,1,2,0};
//    int arr[] = {-2,1,2,-2,1,2};
//    bool i = find132pattern(arr, sizeof(arr)/sizeof(int));
    bool i = find132pattern(arr, num2);
    printf("%d", i);
}

bool find132pattern(int* nums, int numsSize) {
    
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
    return find132pattern(pfirst, numsSize - (int)(pfirst - pcuror));
}


@end
