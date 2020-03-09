//
//  SectionHeaderView.m
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/7.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "SectionHeaderView.h"
#import "Masonry.h"

@interface SectionHeaderView ()
{
    UIImageView *_rightImageView;
}
@end

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sort_normal"] highlightedImage:[UIImage imageNamed:@"icon_sort_high"]];
        [self addSubview:_label];
        [self addSubview:_rightImageView];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.and.bottom.equalTo(self);
        }];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setHighlight:(BOOL)enable {
    _rightImageView.highlighted = enable;
}

@end
