//
//  OKBMultiLevelDropMenuTVHeaderView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelDropMenuTVHeaderView.h"
#import <Masonry/Masonry.h>

@implementation OKBMultiLevelDropMenuTVHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *tmp = [[UIView alloc] initWithFrame:frame];
        [self addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        _contentView = tmp;
    }
    return self;
}

@end
