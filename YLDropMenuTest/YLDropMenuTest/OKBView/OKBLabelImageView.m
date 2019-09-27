//
//  LabelImageView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBLabelImageView.h"
#import <Masonry/Masonry.h>

@interface OKBLabelImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation OKBLabelImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
        tmp.text = @"--";
        tmp.font = [UIFont systemFontOfSize:11];
        tmp.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1];
        [self.contentView addSubview:tmp];
        UIView *superView = self.contentView;
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(superView);
            make.centerX.equalTo(superView);
            make.top.equalTo(superView).offset(5);
            make.bottom.equalTo(superView).offset(-5);
        }];
        _textLbl = tmp;
        
        UIImage *image = [UIImage imageNamed:@"icon_packdown"];
        _image = image;
        
        UIImage *highlightedImage = [UIImage imageNamed:@"icon_packup"];
        _highlightedImage = highlightedImage;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tmp.mas_right).offset(5);
            make.centerY.equalTo(superView);
        }];
        imageView.image = image;
        imageView.highlightedImage = highlightedImage;
        
        _imageView = imageView;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
}

- (void)setHighlightedImage:(UIImage *)highlightedImage {
    _imageView.highlightedImage = highlightedImage;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.imageView.highlighted = selected;
    if (selected) {
        self.textLbl.textColor = [UIColor colorWithRed:48/255.f green:117/255.f blue:238/255.f alpha:1];
    }
    else {
        self.textLbl.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1];
    }
}

- (void)renderMenuItemViewWithUserInfo:(id)userInfo {
    NSString *str = (NSString *)userInfo;
    self.textLbl.text = str;
}

@end
