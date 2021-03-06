//
//  OKBMultiLevelListBaseTVCell.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/24.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListAbsTVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKBMultiLevelListBaseTVCell : OKBMultiLevelListAbsTVCell

@property (nonatomic, strong) UILabel *innerLbl;

- (void)renderCustomCell:(NSString *)item;

@end

NS_ASSUME_NONNULL_END
