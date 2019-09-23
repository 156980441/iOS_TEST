//
//  OKBDropMenuItemView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 类似 UITableViewCell 的封装
 */
@interface OKBMenuItemView : UIView

@property (nonatomic, readonly) UIView *contentView;

/**
 default: NO
 */
@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
