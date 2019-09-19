//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelDropDownMenuVC.h"
#import "OKBMultiLevelDropDownMenuView.h"
#import <Masonry/Masonry.h>

@interface OKBMultiLevelDropDownMenuVC ()
{
    NSInteger _levels;
}
@property (nonatomic, strong) OKBMultiLevelDropDownMenuView *multiLeveldropDownMenuView;
@end

@implementation OKBMultiLevelDropDownMenuVC

- (instancetype)initWithMultiLevel:(NSInteger)levels {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _levels = levels;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.multiLeveldropDownMenuView];
    [self.multiLeveldropDownMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}


#pragma mark - OKBMultiLevelDropDownMenuViewDelegate

- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return 32;
}

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu didSelectInTableView:(nonnull id<OKBMultiLevelMenuProtocol>)model {

}

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:12];
    tmp.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
    tmp.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
    if (index == 0) {
        tmp.text = @"标的";
    } else if (index == 1) {
        tmp.text = @"到期时间";
    } else {
        tmp.text = @"价格";
    }
    return tmp;
}

- (OKBMultiLevelDropDownMenuView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        OKBMultiLevelDropDownMenuView *tmp = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:_levels];
        tmp.delegate = self;
        _multiLeveldropDownMenuView = tmp;
    }
    return _multiLeveldropDownMenuView;
}

@end
