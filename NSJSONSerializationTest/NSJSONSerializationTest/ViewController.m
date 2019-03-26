//
//  ViewController.m
//  NSJSONSerializationTest
//
//  Created by fanyl on 2018/2/5.
//  Copyright © 2018年 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *jsonStr = @"{\"number\":81.6}";
    NSData *jsonData_ = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonParsingError_ = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData_ options:NSJSONReadingAllowFragments error:&jsonParsingError_];
    NSString *value = dic[@"number"];
    
    
    
    NSLog(@"NSJSONSerialization value:%@", value);
    NSLog(@"decimalNumberWithDouble value:%@", decimalNumberWithDouble([dic[@"number"] doubleValue]));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString *decimalNumberWithDouble(double conversionValue)
{
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

@end
