//
//  YL2LabelsView.m
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import "YL2LabelsView.h"

@implementation YL2LabelsView

#pragma mark - setter and getter

- (UILabel*)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [UIFactory defaultLabel];
    }
    return _firstLabel;
}

- (UILabel*)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [UIFactory defaultLabel];
    }
    return _secondLabel;
}

- (void)setSpace:(CGFloat)space {
    if (_space != space) {
        _space = space;
        [self layoutUI];
    }
}

- (void)setLayoutAlignment:(YLLabelsViewLayoutAlignment)layoutAlignment {
    if (_layoutAlignment != layoutAlignment) {
        _layoutAlignment = layoutAlignment;
        [self layoutUI];
    }
}

- (void)setLayoutDirection:(YLLabelsViewLayoutDirection)layoutDirection {
    if (_layoutDirection != layoutDirection) {
        _layoutDirection = layoutDirection;
        [self layoutUI];
    }
}

#pragma mark - initialize

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _layoutAlignment = YLLabelsViewLayoutAlignmentCenter;
        _layoutDirection = YLLabelsViewLayoutDirection_horizontal;
        _space = 0.0f;
        
        [self setupUI];
        [self layoutUI];
    }
    return self;
}

#pragma mark - OKViewProtocol

- (void)setupUI {
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
}

- (void)layoutUI {
    if (self.layoutDirection == YLLabelsViewLayoutDirection_horizontal) {
        if (self.layoutAlignment == YLLabelsViewLayoutAlignmentCenter) { // 两个 Label 中间吸附
            [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self.mas_centerX).offset(-self.space/2);
            }];
            [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self.mas_centerX).offset(self.space/2);
                make.right.equalTo(self);
            }];
            self.firstLabel.textAlignment = NSTextAlignmentRight;
            self.secondLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if (self.layoutAlignment == YLLabelsViewLayoutAlignmentLeft) { // 两个 Label 靠左吸附
            [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self).offset(0);
            }];
            [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self.firstLabel.mas_right).offset(self.space);
                make.right.equalTo(self);
            }];
            self.firstLabel.textAlignment = self.secondLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if (self.layoutAlignment == YLLabelsViewLayoutAlignmentRight) { // 两个 Label 靠右吸附
            [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.right.equalTo(self.secondLabel.mas_left).offset(- self.space);
                make.left.equalTo(self);
            }];
            [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.right.equalTo(self).offset(0);
            }];
            self.firstLabel.textAlignment = self.secondLabel.textAlignment = NSTextAlignmentRight;
        }
        else if (self.layoutAlignment == YLLabelsViewLayoutAlignmentExpand) { // 两个 Label 边界吸附
            [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self);
            }];
            [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self.firstLabel.mas_right).offset(-self.space);
                make.right.equalTo(self).offset(0);
            }];
            self.firstLabel.textAlignment = NSTextAlignmentLeft;
            self.secondLabel.textAlignment = NSTextAlignmentRight;
        }
    }
    else if (self.layoutDirection == YLLabelsViewLayoutDirection_vertical) {
        [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(- self.space / 2);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).offset(self.space / 2);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        if (self.layoutAlignment == YLLabelsViewLayoutAlignmentCenter) {
            self.firstLabel.textAlignment = self.secondLabel.textAlignment = NSTextAlignmentCenter;
        }
        else if (self.layoutAlignment == YLLabelsViewLayoutAlignmentLeft) {
            self.firstLabel.textAlignment = self.secondLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if (self.layoutAlignment == YLLabelsViewLayoutAlignmentRight) {
            self.firstLabel.textAlignment = self.secondLabel.textAlignment = NSTextAlignmentRight;
        }
    }
}

@end

YL2LabelsView* get2LabelsView() {
    YL2LabelsView* twoLbl = [[YL2LabelsView alloc] initWithFrame:CGRectZero];
    twoLbl.layoutDirection = YLLabelsViewLayoutDirection_vertical;
    twoLbl.layoutAlignment = YLLabelsViewLayoutAlignmentLeft;
    twoLbl.firstLabel.font = [UIFont systemFontOfSize:14];
    twoLbl.secondLabel.font = [UIFont systemFontOfSize:12];
    twoLbl.firstLabel.textColor = YLColor_Title;
    twoLbl.secondLabel.textColor = YLColor_Subtitle;
    return twoLbl;
}
