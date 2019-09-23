//
//  OKBMultiLevelMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class OKBMultiLevelMenuView, OKBMultiLevelMenuNode;

@protocol OKBMultiLevelMenuViewDelegate <NSObject>

@optional
- (CGFloat)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu
heightForHeaderInTableView:(UITableView *)tableView
                  atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu
           viewForHeaderInTableView:(UITableView *)tableView
                            atIndex:(NSInteger)index;

- (void)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu
  didSelectInTableView:(OKBMultiLevelMenuNode *)model;

@end

@interface OKBMultiLevelMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num widthWeight:(nullable NSString *)intColonInt;

@property (nonatomic, strong) id<OKBMultiLevelMenuViewDelegate> delegate;

- (void)reloadDataWithRootDataSource:(OKBMultiLevelMenuNode *)rootDataSource;

- (UITableView *)tableViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
