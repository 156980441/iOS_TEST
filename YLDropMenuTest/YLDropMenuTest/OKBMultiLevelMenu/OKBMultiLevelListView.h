//
//  OKBMultiLevelMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class OKBMultiLevelListView, OKBMultiLevelListNode, OKBMultiLevelListBaseTVCell;

@protocol OKBMultiLevelMenuViewDelegate <NSObject>

@optional
- (CGFloat)multiLevelList:(OKBMultiLevelListView *)dropDownMenu
heightForHeaderInTableView:(UITableView *)tableView
                  atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelList:(OKBMultiLevelListView *)dropDownMenu
           viewForHeaderInTableView:(UITableView *)tableView
                            atIndex:(NSInteger)index;

- (void)multiLevelList:(OKBMultiLevelListView *)dropDownMenu
  didSelectInTableView:(OKBMultiLevelListNode *)model;

@end

@interface OKBMultiLevelListView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               tableViewCells:(NSArray<Class> *)cells
                  widthWeight:(nullable NSString *)intColonInt;

@property (nonatomic, strong) id<OKBMultiLevelMenuViewDelegate> delegate;

- (void)reloadDataWithRootDataSource:(OKBMultiLevelListNode *)rootDataSource;

- (UITableView *)tableViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
