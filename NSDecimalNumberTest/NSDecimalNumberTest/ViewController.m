//
//  ViewController.m
//  NSDecimalNumberTest
//
//  Created by 赵雪莹 on 2019/3/14.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

/**
 最近在做一个P2P金融理财类的APP,其中对数值精度的要求很高，使用浮点型和双精度型表示，不能达到规定的精度要求。
 能使Objective-C表示并计算更高精度数值的方法，发现了苹果提供用于高精度金融货币交易计算的API(NSDecimalNumber)。
 **/
@interface ViewController ()

@end

@implementation ViewController

- (void)testDecimalNumber {
    double d1 = 0.0001;
    double d2 = 9999.99;
    double d3 = d1 * d2;
    NSLog(@"%f * %f = %f", d1, d2, d3);
}

- (void)test {
    double t_double = 123456789.987654321;
    NSString *t_str = @"123456789.987654321";
    NSLog(@"%@ has decimal digit %d", t_str, getDecimalDigits([t_str cStringUsingEncoding:NSUTF8StringEncoding]));
    NSString *t_double_str = [NSString stringWithFormat:@"%f", t_double];
    NSLog(@"origin double %@ to double %f", t_str, t_double);
    NSLog(@"origin double %@ to string %@", t_str, t_double_str);
    
    NSDecimalNumber *t_dec = [NSDecimalNumber decimalNumberWithString:t_str];
    NSLog(@"origin string %@ to decimal %@", t_str, t_dec.stringValue);
    
    NSNumber *t_num = [NSNumber numberWithDouble:t_double];
    NSDecimalNumber *t_double_num_dec = [NSDecimalNumber decimalNumberWithString:t_num.stringValue];
    NSLog(@"origin double to number to decimal %@", t_double_num_dec.stringValue);
    NSLog(@"只能直接调用 decimalNumberWithString ");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testDecimalNumber];
    [self test];
    
    float tmp = convert2Unit(3);
    
    // mantissa：长整形；exponent：指数；flag：正负数
    NSDecimalNumber * amount0 = [[NSDecimalNumber alloc] initWithMantissa:42
                                                                 exponent:-2
                                                               isNegative:NO]; // 0.42
    NSDecimalNumber * amount1 = [[NSDecimalNumber alloc] initWithMantissa:42
                                                                 exponent:2
                                                               isNegative:NO]; // -4200
    
    //locale代表一种格式,对于这种格式可以参考一下例子去理解
    NSDictionary *locale0 = [NSDictionary dictionaryWithObject:@","
                                                        forKey:NSLocaleDecimalSeparator];    //以","当做小数点格式
    NSDecimalNumber * amount2 = [[NSDecimalNumber alloc] initWithString:@"42,68"
                                                                 locale:locale0];//42.68
    NSLocale *locale5 = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];//法国数据格式,法国的小数点是','逗号
    NSDecimalNumber * amount3 = [[NSDecimalNumber alloc] initWithString:@"42.68"
                                                                 locale:locale5];//42.68
    
    /**
     
      四舍五入策略 :
      Original
         value 1.2  1.21  1.25  1.35  1.27
      Plain    1.2  1.2   1.3   1.4   1.3
      Down     1.2  1.2   1.2   1.3   1.2
      Up       1.2  1.3   1.3   1.4   1.3
      Bankers  1.2  1.2   1.2   1.4   1.3
     roundingMode 要使用的舍入模式，有四种值： NSRoundUp, NSRoundDown, NSRoundPlain, and NSRoundBankers
     scale 结果保留几位小数
     aiseOnExactness 发生精确错误时是否抛出异常，一般为NO
     raiseOnOverflow 发生溢出错误时是否抛出异常，一般为NO
     raiseOnUnderflow 发生不足错误时是否抛出异常，一般为NO
     raiseOnDivideByZero 被0除时是否抛出异常，一般为YES
     
     **/
    NSDecimalNumberHandler * rounUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                             scale:1
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *subtotalAmount = [NSDecimalNumber decimalNumberWithMantissa:4284
                                                                        exponent:-2
                                                                      isNegative:NO];
    NSDecimalNumber * roundUpAmount = [subtotalAmount decimalNumberByRoundingAccordingToBehavior:rounUp];
    
    NSDecimalNumber *count0 = [NSDecimalNumber decimalNumberWithString:@"41"];
    NSDecimalNumber *count1 = [NSDecimalNumber decimalNumberWithString:@"43"];
    NSComparisonResult result = [count0 compare:count1];
    // 上升 = NSOrderedAscending  1、2、3、。。。。。
    if (result == NSOrderedAscending) {
        //41 < 43
    } else if (result == NSOrderedSame) {
        //41 == 43
    } else if (result == NSOrderedDescending) {
        //41 > 43
    }
    
}

NSString* doubleByMultiplyingBy(NSString *num1, NSString *num2, int scale, NSRoundingMode roundingMode) {
    return nil;
}

float convert2Unit(int num)
{
    float tmp = 1.0f;
    for (int i = 0; i < num; i++) {
        tmp = tmp / 10;
    }
    return tmp;
}

// char const *ptr 和 const char *ptr 等价，*ptr 的值为 const，不能修改。
// 但是 ptr 的声明并不意味着它指向的值实际上就是一个常量，而只是意味着对 ptr 而言，这个值是常量。
// 实验如下：ptr 指向 str，而 str 不是 const，可以直接通过 str 变量来修改 str 的值，但是确不能通过 ptr 指针来修改。所以为什么 NSString 要是 copy 的
// char * const ptr 即 const 指针，不能修改ptr指针，但是可以修改该指针指向的内容
int getDecimalDigits(const char *chars)
{
    int value = 0;
    char *tmp = NULL;
    
    if (chars == NULL) {
        return value;
    }
    else {
        tmp = strstr(chars,".");
        if(tmp != NULL) {
            value = (int)strlen(tmp + 1);
        }
    }
    return value;
}

@end
