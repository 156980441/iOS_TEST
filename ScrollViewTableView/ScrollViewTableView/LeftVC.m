//
//  LeftVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/10/30.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "LeftVC.h"

@interface LeftVC ()
@property (nonatomic, strong) UILabel *textLbl;
@end

@implementation LeftVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor yellowColor];
        self.textLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLbl.text = @"左边黄色";
        [self.view addSubview:self.textLbl];
        [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

@end
