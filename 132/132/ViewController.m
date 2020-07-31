//
//  ViewController.m
//  132
//
//  Created by fanyl on 2020/7/26.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#include "find132WithMin.h"
#include "find132WithStack.h"
#include "find132WithWhile.h"
#include "find132WithRecursion.h"

@interface ViewController ()

@end

@implementation ViewController

void chars2IntArr (const char* str, int *output, unsigned int length) {
    for (int i = 0; i < length; i++) {
        output[i] = atoi(&str[i * 2]);
    }
    
    printf("\n======\n");
    
    for (int i = 0; i < length; i++) {
        //        printf("%d,", output[i]);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [NSString stringWithFormat:@"%@%@", str, @"/132_test.txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    const char *cStr = dataStr.UTF8String;
    size_t num = strlen(cStr);
    //    NSLog(@"%s", cStr);
    
    size_t num2 = ceil(strlen(cStr) / 2);
    int *arr = malloc(sizeof(int) * num2);
    chars2IntArr(cStr, arr, (unsigned int)num2);
    
    //    int arr[] = {-2,1,2,-2,1,2};
    //    bool i = find132pattern(arr, sizeof(arr)/sizeof(int));
    
    bool i = find132patternWithMin(arr, num2);
    printf("min %d\n", i);
    i = find132patternStack(arr, num2);
    printf("stack %d\n", i);
}

@end
