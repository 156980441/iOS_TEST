//
//  YLSearchBar.m
//  SearchViewTest
//
//  Created by fanyl on 2019/3/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "YLSearchBar.h"

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
    self.searchBarTF.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setCursorColor:(UIColor *)cursorColor {
    [self.searchBarTF setTintColor:cursorColor];
}

- (void)setNightMode:(BOOL)nightMode {
    if (nightMode) {
        UIImage* image = [UIImage imageNamed:@"rect_circle_corner_gray_night"];
        self.searchBarTF.background = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    }
    else {
        UIImage* image = [UIImage imageNamed:@"rect_circle_corner_gray"];
        self.searchBarTF.background = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    }
}

- (UITextField*)searchBarTF {
    if (!_searchBarTF) {
        UITextField *tmp = UITextField.new;
        tmp.keyboardType = UIKeyboardTypeDefault;
        tmp.returnKeyType = UIReturnKeySearch;
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

@end
