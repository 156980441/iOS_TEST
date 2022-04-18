//
//  CapsuleView.m
//  find_me
//
//  Created by yunlong on 2022/4/18.
//

#import "CapsuleView.h"
#import <Masonry/Masonry.h>

@interface CapsuleView ()

@end

@implementation CapsuleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addUI];
    }
    return self;
}

- (void)addUI {
    self.backgroundColor = [UIColor grayColor];
    [self addSubview:self.label];
    self.label.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutUI {
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.insets);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutUI];
    self.layer.cornerRadius = ceil(CGRectGetHeight(self.frame) / 2);
}

- (void)setText:(NSString *)text {
    if (![text isEqualToString:self.label.text]) {
        self.label.text = text;
    }
}

@end
