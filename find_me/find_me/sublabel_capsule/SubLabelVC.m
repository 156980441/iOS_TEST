//
//  SubLabelVC.m
//  find_me
//
//  Created by yunlong on 2022/4/18.
//

#import "SubLabelVC.h"
#import <Masonry/Masonry.h>
#import "SubLabel.h"
#import "CapsuleView.h"

@interface SubLabelVC ()

@end

@implementation SubLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
//        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
//        make.top.equalTo(self.view).offset(10);
        make.top.equalTo(self.view.mas_topMargin).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(60);
    }];
    
    SubLabel *sublabel = [[SubLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:sublabel];
    [sublabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(60);
    }];
    
    SubLabel *sublabel2 = [[SubLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:sublabel2];
    [sublabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(sublabel.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(60);
    }];
    
    label.text = @"UILabel";
    sublabel.text = @"subUILabel";
    sublabel2.text = @"subUILabel NSTextAlignmentCenter";
    label.backgroundColor = [UIColor grayColor];
    sublabel.backgroundColor = [UIColor grayColor];
    sublabel2.backgroundColor = [UIColor grayColor];
    
    sublabel2.textAlignment = NSTextAlignmentCenter;
    
    CapsuleView *capsule = [[CapsuleView alloc] initWithFrame:CGRectZero];
    capsule.text = @"Capsule View";
    capsule.label.backgroundColor = [UIColor whiteColor];
    capsule.insets = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.view addSubview:capsule];
    [capsule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(sublabel2.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(60);
    }];
}

@end
