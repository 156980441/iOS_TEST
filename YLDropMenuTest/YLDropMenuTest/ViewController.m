//
//  ViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "OKBDropMenuView.h"
#import "OKBDropMenuItemView.h"
#import "LabelImageView.h"
#import <Masonry/Masonry.h>

@interface ViewController () <OKBDropMenuViewDataSource, OKBDropMenuViewDelegate>
@property (nonatomic, strong) OKBDropMenuView *dropDownMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dropDownMenu];
    
    [self.dropDownMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
}

- (NSInteger)numberOfItemsInDropView:(OKBDropMenuView *)dropMenuView {
    return 4;
}

- (nullable OKBDropMenuItemView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewForItemAtIndex:(NSInteger)index {
    LabelImageView *tmp = [[LabelImageView alloc] initWithFrame:CGRectZero];
    if (index == 3) {
        tmp.image = [UIImage imageNamed:@"icon_setting"];
    }
    return tmp;
}

- (UIView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewInItemAtIndex:(NSInteger)index {
    UIView *tmp  = [[UIView alloc] initWithFrame:CGRectZero];
    if (index == 0) {
        tmp.backgroundColor = [UIColor redColor];
    }
    else {
        tmp.backgroundColor = [UIColor yellowColor];
    }
    return tmp;
}

- (CGFloat)dropMenuView:(OKBDropMenuView *)dropMenuView heightForViewAtIndexPath:(NSInteger)index {
    return 160;
}

- (void)dropMenuView:(OKBDropMenuView *)dropMenuView didSelectItemAtIndexPath:(NSInteger)index {
    
}

- (OKBDropMenuView *)dropDownMenu {
    if (!_dropDownMenu) {
        OKBDropMenuView *tmp = [[OKBDropMenuView alloc] initWithFrame:CGRectZero];
        tmp.delegate = self;
        tmp.dataSource = self;
        _dropDownMenu = tmp;
    }
    return _dropDownMenu;
}


@end
