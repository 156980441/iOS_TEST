//
//  YLSearchBar.m
//  SearchViewTest
//
//  Created by fanyl on 2019/3/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "YLSearchBar.h"
#import <Masonry/Masonry.h>

@interface YLSearchBar () <UITextFieldDelegate>

@end

@implementation YLSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.searchBarTF];
    [self addSubview:self.cancel];
    [self.searchBarTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(7);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15).priority(300);
        make.bottom.equalTo(self.mas_bottom).offset(-7);
    }];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.searchBarTF);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.searchBarTF.mas_right).offset(5);
        make.width.mas_equalTo(0);
    }];
}

- (void)p_showCancelAnimation {
    // 告知需要更改约束，若需要则更新，下面添加动画效果才起作用
    [self.cancel.superview setNeedsUpdateConstraints];
    [UIView animateWithDuration:YLAnimationTime animations:^{
        [self.cancel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
        }];
        [self.searchBarTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cancel.mas_left).offset(-5);
        }];
        // 告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.cancel.superview layoutIfNeeded];
    }];
}

- (void)p_hideCancelAnimation {
    // 告知需要更改约束
    [self.cancel.superview setNeedsUpdateConstraints];
    [UIView animateWithDuration:YLAnimationTime animations:^{
        [self.cancel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [self.searchBarTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15).priority(300);
        }];
        // 告知父类控件绘制，不添加注释的这两行的代码无法生效
        [self.cancel.superview layoutIfNeeded];
    }];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    [self.searchBarTF setTintColor:cursorColor];
}

- (void)setNightMode:(BOOL)nightMode {
    if (nightMode) {
        UIImage* image = [UIImage imageNamed:@"rect_circle_corner_gray_night"];
        self.searchBarTF.background = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
        [self setCursorColor:[UIColor whiteColor]];
        self.searchBarTF.textColor = [UIColor whiteColor];
    }
    else {
        UIImage* image = [UIImage imageNamed:@"rect_circle_corner_gray"];
        self.searchBarTF.background = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
        [self setCursorColor:[UIColor blueColor]];
        self.searchBarTF.textColor = [UIColor blackColor];
    }
}

- (UITextField*)searchBarTF {
    if (!_searchBarTF) {
        UITextField *tmp = UITextField.new;
        tmp.keyboardType = UIKeyboardTypeDefault;
        tmp.returnKeyType = UIReturnKeySearch;
        tmp.backgroundColor = [UIColor clearColor];
        tmp.clearButtonMode = UITextFieldViewModeWhileEditing;
        tmp.borderStyle = UITextBorderStyleNone;
        tmp.font = [UIFont systemFontOfSize:13];
        tmp.clipsToBounds = YES;
        tmp.layer.cornerRadius  = 2.f;
        tmp.delegate = self;
        tmp.placeholder = @"please input key words";
        UIImage* image = [UIImage imageNamed:@"rect_circle_corner_gray"];
        tmp.background = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]; // 设置背景的好处是排除了系统差异造成的样式改变
        
        
        UIImage *search = [UIImage imageNamed:@"icon_search_black_night"];
        UIImageView *left = [[UIImageView alloc] initWithImage:search];
        tmp.leftView = left;
        tmp.leftViewMode = UITextFieldViewModeAlways;
        _searchBarTF = tmp;
    }
    return _searchBarTF;
}

- (UIButton*)cancel {
    if (!_cancel) {
        UIButton *tmp = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmp setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancel = tmp;
    }
    return _cancel;
}

#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self p_showCancelAnimation];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yl_searchBarDidBeginEditing:)]) {
        [self.delegate yl_searchBarDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self p_hideCancelAnimation];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yl_searchBarDidEndEditing:)]) {
        [self.delegate yl_searchBarDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
