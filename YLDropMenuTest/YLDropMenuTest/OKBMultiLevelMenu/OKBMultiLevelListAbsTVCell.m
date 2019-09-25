//
//  OKBMultiLevelListAbsTVCell.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/24.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListAbsTVCell.h"

@implementation OKBMultiLevelListAbsTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderCustomCell:(NSString *)item {
    NSAssert(0, @"renderCustomCell is abstract method. Please overriding it");
}

@end
