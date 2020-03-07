//
//  SectionHeaderView.m
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/7.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "SectionHeaderView.h"
#import "Masonry.h"

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.and.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
