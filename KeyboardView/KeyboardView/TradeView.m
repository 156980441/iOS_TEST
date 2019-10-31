//
//  TradeView.m
//  KeyboardView
//
//  Created by fanyl on 2019/10/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "TradeView.h"
#import "Masonry.h"

@implementation TradeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _priceTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _priceTF.placeholder = @"价格";
        _amountTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _amountTF.placeholder = @"数量";
        _warningLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _warningLbl.text = @"警告";
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:_priceTF];
        [self addSubview:_amountTF];
        [self addSubview:_warningLbl];
        
        [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(40);
        }];
        [_warningLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceTF.mas_bottom).offset(5);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(20);
        }];
        [_amountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_warningLbl.mas_bottom).offset(5);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self).offset(-15);
        }];
        
    }
    return self;
}

@end
