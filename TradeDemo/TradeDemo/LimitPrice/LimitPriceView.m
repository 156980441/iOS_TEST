//
//  LimitPriceView.m
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "LimitPriceView.h"
#import "AddMinusTextFieldView.h"
#import "Masonry.h"

@interface LimitPriceView ()
{
    AddMinusTextFieldView *_priceView;
    AddMinusTextFieldView *_amountView;
    UILabel *_valueLbl;
}
@end

@implementation LimitPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self layoutUI];
    }
    return self;
}

#if DEBUG
- (void)dealloc {
    NSLog(@"%s",__func__); // 内存测试
}
#endif


- (void)layoutUI {
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    [_valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceView.mas_bottom).offset(2);
        make.left.and.right.equalTo(_priceView);
    }];
    [_amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLbl.mas_bottom).offset(2);
        make.left.and.right.equalTo(_priceView);
        make.height.mas_equalTo(_priceView);
    }];
}

- (void)setupUI {
    
    _priceView = [[AddMinusTextFieldView alloc] initWithFrame:CGRectZero];
    _amountView = [[AddMinusTextFieldView alloc] initWithFrame:CGRectZero];
    _valueLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _valueLbl.text = @"Value:";
    
    [self addSubview:_priceView];
    [self addSubview:_amountView];
    [self addSubview:_valueLbl];
    
}

@end
