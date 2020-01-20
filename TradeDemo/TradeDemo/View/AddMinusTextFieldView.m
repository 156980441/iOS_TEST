//
//  AddMinusTextFieldView.m
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "AddMinusTextFieldView.h"
#import "Masonry.h"

@interface AddMinusTextFieldView ()
{
    UITextField *_textField;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UIView *_leftLine;
    UIView *_rightLine;
}
@end

@implementation AddMinusTextFieldView

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
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(_leftBtn);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(_leftBtn.mas_right);
        make.right.equalTo(_rightBtn.mas_left);
    }];
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(_textField.mas_left);
        make.width.mas_equalTo(0.5f);
    }];
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(_textField.mas_right);
        make.width.mas_equalTo(0.5f);
    }];
}

- (void)setupUI {
    
    self.layer.cornerRadius = 3.0f;
    self.clipsToBounds = YES;
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.borderStyle = UITextBorderStyleLine;
    
    [_leftBtn setTitle:@"-" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    _leftLine = [[UIView alloc] initWithFrame:CGRectZero];
    _rightLine = [[UIView alloc] initWithFrame:CGRectZero];
    
    _leftLine.backgroundColor = [UIColor colorWithRed:244/250.f green:244/250.f blue:230/250.f alpha:1];
    _rightLine.backgroundColor = [UIColor colorWithRed:244/250.f green:244/250.f blue:230/250.f alpha:1];

    [self addSubview:_leftBtn];
    [self addSubview:_rightBtn];
    [self addSubview:_textField];
    [self addSubview:_leftLine];
    [self addSubview:_rightLine];
}

@end
