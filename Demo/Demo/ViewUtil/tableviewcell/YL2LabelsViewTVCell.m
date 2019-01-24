//
//  OKGS2LabelsViewTVCell.m
//  AFNetworking
//
//  Created by fanyl on 2018/5/17.
//

#import "YL2LabelsViewTVCell.h"
#import "YL2LabelsView.h"

NSString* const g_2LabelsViewTVCellId = @"2LabelsViewTVCellId";

@implementation YL2LabelsViewTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        [self layoutUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.innerView];
    self.backgroundColor = YLColor_Background;
    self.innerView.backgroundColor = YLColor_Module;
}

-(void)layoutUI {
    [self.innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (YL2LabelsView*)innerView {
    if (!_innerView) {
        YL2LabelsView *tmp = get2LabelsView();
        tmp.layoutAlignment = YLLabelsViewLayoutAlignmentExpand;
        tmp.layoutDirection = YLLabelsViewLayoutDirection_horizontal;
        tmp.secondLabel.textColor = YLColor_Title;
        _innerView = tmp;
    }
    return _innerView;
}

@end
