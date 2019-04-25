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
    [self.searchBarTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(7, 15, 7, 15));
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

#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yl_searchBarDidBeginEditing:)]) {
        [self.delegate yl_searchBarDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
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
