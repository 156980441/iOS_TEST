//
//  SelectTVCell.m
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/7.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "SelectTVCell.h"
#import "Masonry.h"

@implementation SelectTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_choose_blue"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 关闭点击效果
        [self.contentView addSubview:label];
        [self.contentView addSubview:rightImageView];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.and.bottom.equalTo(self.contentView);
        }];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

@end
