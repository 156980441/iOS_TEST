//
//  OKBMultiLevelDropDownMenuLabelTVHeader.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListLabelTVHeader.h"
#import <Masonry/Masonry.h>

@implementation OKBMultiLevelListLabelTVHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
        tmp.text = @"--";
        tmp.font = [UIFont systemFontOfSize:11];
        tmp.textAlignment = NSTextAlignmentCenter;
        tmp.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
        tmp.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
        [self addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _textLbl = tmp;
    }
    return self;
}

- (CGFloat)height {
    return 30;
}

@end
