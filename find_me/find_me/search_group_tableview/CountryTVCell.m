//
//  CountryTVCell.m
//  find_me
//
//  Created by yunlong on 2022/4/25.
//

#import "CountryTVCell.h"
#import <Masonry/Masonry.h>

@interface CountryTVCell ()
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UIImageView *checkImage;
@end

@implementation CountryTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.flagLabel];
        [self.contentView addSubview:self.checkImage];
        
        [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.height.mas_equalTo(64);
            make.top.bottom.equalTo(self.contentView);
        }];
        [self.checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-24);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
    }
    return self;
}

- (void)setDisplayStr:(NSString *)displayStr {
    self.flagLabel.text = displayStr;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.checkImage.hidden = !isSelected;
}

- (UIImageView *)checkImage {
    if (!_checkImage) {
        _checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"okla_done"]];
    }
    return _checkImage;
}

- (UILabel *)flagLabel{
    if (!_flagLabel) {
        _flagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _flagLabel.font = [UIFont systemFontOfSize:16];
        _flagLabel.textColor = [UIColor blackColor];
    }
    return _flagLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
