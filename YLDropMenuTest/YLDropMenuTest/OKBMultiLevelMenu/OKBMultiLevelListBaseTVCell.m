//
//  OKBMultiLevelListBaseTVCell.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/24.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListBaseTVCell.h"
#import <Masonry/Masonry.h>

NSString* const g_OKBMultiLevelListBaseTVCellId = @"OKBMultiLevelListBaseTVCellId";

@implementation OKBMultiLevelListBaseTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        [self layoutUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel* )innerLbl {
    if (!_innerLbl) {
        UILabel* tmp = [[UILabel alloc] initWithFrame:CGRectZero];
        tmp.textColor = [UIColor colorWithRed:92/255.f green:94/255.f blue:102/255.f alpha:1];
        tmp.font = [UIFont systemFontOfSize:14];
        tmp.textAlignment = NSTextAlignmentCenter;
        tmp.userInteractionEnabled = YES;
        tmp.text = @"--.--";
        tmp.numberOfLines = 0;
        //        tmp.adjustsFontSizeToFitWidth = YES;
        _innerLbl = tmp;
    }
    return _innerLbl;
}


- (void)setupUI {
    [self.contentView addSubview:self.innerLbl];
}

-(void)layoutUI {
    [self.innerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.innerLbl.textColor = [UIColor colorWithRed:48/255.f green:117/255.f blue:238/255.f alpha:1];
    }
    else {
        self.innerLbl.textColor = [UIColor colorWithRed:92/255.f green:94/255.f blue:102/255.f alpha:1];
    }
}

@end
