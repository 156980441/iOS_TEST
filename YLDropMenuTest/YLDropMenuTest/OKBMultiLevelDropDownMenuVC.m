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

- (OKBMultiLevelDropDownMenuView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        OKBMultiLevelDropDownMenuView *tmp = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:_levels];
        _multiLeveldropDownMenuView = tmp;
    }
    return _multiLeveldropDownMenuView;
}

@end
