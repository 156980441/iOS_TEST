//
//  LimitPriceStrategy.m
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "LimitPriceStrategy.h"
#import "LimitPriceView.h"
#import "Masonry.h"

@interface LimitPriceStrategy ()
{
    LimitPriceView *_limitPriceView;
}
@end

@implementation LimitPriceStrategy

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _limitPriceView = [[LimitPriceView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_limitPriceView];
    }
    return self;
}

- (void)viewDidLoad {
    [_limitPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

@end
