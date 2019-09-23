//
//  OKBDropMenuItemView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuItemView.h"
#import <Masonry/Masonry.h>

@implementation OKBMenuItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *tmp = [[UIView alloc] initWithFrame:frame];
        [self addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        _contentView = tmp;
        
        _selected = NO;
    }
    return self;
}

@end
