//
//  ViewController.m
//  UITextFieldTest
//
//  Created by 我叫不紧张 on 2019/3/10.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    field.delegate = self;
    field.placeholder = @"请输入姓名";
    field.textColor = [UIColor redColor];
    field.font = [UIFont systemFontOfSize:14];
    field.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:field];

}

// 是否可以编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
    return YES;
}

// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"%s", __func__);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%s", __func__);
    return YES;
}


@end
