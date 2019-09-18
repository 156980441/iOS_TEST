//
//  OKBMenuViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuViewController.h"
#import "OKBMenuView.h"

#import <Masonry/Masonry.h>

@interface OKBMenuViewController ()
@property (nonatomic, strong) OKBMenuView *menuView;
@end

@implementation OKBMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

- (OKBMenuView *)menuView {
    if (!_menuView) {
        OKBMenuView *tmp = [[OKBMenuView alloc] initWithFrame:CGRectZero];
        _menuView = tmp;
    }
    return _menuView;
}

@end
