//
//  CountryVC.m
//  find_me
//
//  Created by yunlong on 2022/4/25.
//

#import "CountryVC.h"
#import <Masonry/Masonry.h>

@interface CountryVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@end

@implementation CountryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tf = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tf];
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    self.tf.delegate = self;
    self.tf.rightViewMode = UITextFieldViewModeAlways;
    self.tf.textColor = [UIColor blackColor];
    self.tf.font = [UIFont systemFontOfSize:12];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:(@"keyboard_arrow_down")] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(countrySelect) forControlEvents:UIControlEventTouchUpInside];
    self.tf.rightView = btn;
}


- (void)countrySelect {
    
}

// 实现响应单不可编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self countrySelect];
    return NO;
}

@end
