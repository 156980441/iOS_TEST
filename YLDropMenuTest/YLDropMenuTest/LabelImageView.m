//
//  LabelImageView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "LabelImageView.h"
#import <Masonry/Masonry.h>

@interface LabelImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LabelImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
        tmp.text = @"BTC/USDT";
        tmp.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:tmp];
        UIView *superView = self.contentView;
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(superView);
            make.centerX.equalTo(superView);
            make.top.equalTo(superView).offset(5);
            make.bottom.equalTo(superView).offset(-5);
        }];
        _textLbl = tmp;
        
        UIImage *image = [UIImage imageNamed:@"Icon"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tmp.mas_right).offset(5);
            make.centerY.equalTo(superView);
        }];
        _image = image;
        _imageView = imageView;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
}

@end
