//
//  BannerCVCell.m
//  3dCollectionView
//
//  Created by yunlong on 2021/6/7.
//

#import "BannerCVCell.h"

@interface BannerCVCell ()
{
    UIImageView *_v;
}
@end

@implementation BannerCVCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateUIWithData:(id)data {
    [_v removeFromSuperview];
    _v = [[UIImageView alloc] initWithImage:(UIImage *)data];
    _v.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_v];
    _v.frame = self.contentView.bounds;
}

@end
