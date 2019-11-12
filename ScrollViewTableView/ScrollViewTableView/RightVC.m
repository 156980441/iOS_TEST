//
//  RightVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/10/30.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "RightVC.h"
#import "Masonry.h"

@interface RightVC ()
@property (nonatomic, strong) UILabel *textLbl;
@end

@implementation RightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.textLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    self.textLbl.text = @"右边红色";
    self.textLbl.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.textLbl];
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

@end
