//
//  OKBMultiLevelListAbsTVCell.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/24.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 多级列表基础 Cell，请理解成抽象类，使用方法参见子类 OKBMultiLevelListBaseTVCell
@interface OKBMultiLevelListAbsTVCell : UITableViewCell

/// 子类继承后实现
/// @param item 字符串，用于多级列表显示标题
- (void)renderCustomCell:(NSString *)item;

@end

NS_ASSUME_NONNULL_END
