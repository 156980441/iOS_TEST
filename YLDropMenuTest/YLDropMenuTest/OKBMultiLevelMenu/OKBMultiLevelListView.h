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
- (CGFloat)multiLevelList:(OKBMultiLevelListView *)multiLevelListView
heightForHeaderInTableView:(UITableView *)tableView
                  atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelList:(OKBMultiLevelListView *)multiLevelListView
           viewForHeaderInTableView:(UITableView *)tableView
                            atIndex:(NSInteger)index;

- (void)multiLevelList:(OKBMultiLevelListView *)multiLevelListView
  didSelectInTableView:(OKBMultiLevelListNode *)model;

@end

@interface OKBMultiLevelListView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               tableViewCells:(NSArray<Class> *)cells
                  widthWeight:(nullable NSString *)intColonInt;

@property (nonatomic, strong) id<OKBMultiLevelMenuViewDelegate> delegate;

- (void)reloadDataWithRootDataSource:(OKBMultiLevelListNode *)rootDataSource;

- (void)setSelectedNode:(OKBMultiLevelListNode *)node;

- (UITableView *)tableViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
