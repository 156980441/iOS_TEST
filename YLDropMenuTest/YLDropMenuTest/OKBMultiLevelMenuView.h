//
//  OKBMultiLevelDropDownMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OKBMultiLevelMenuProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@class OKBMultiLevelMenuView;

@protocol OKBMultiLevelMenuViewDelegate <NSObject>

@optional
- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelMenuView *)dropDownMenu
       heightForHeaderInTableView:(UITableView *)tableView
                          atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelMenuView *)dropDownMenu
                   viewForHeaderInTableView:(UITableView *)tableView
                                    atIndex:(NSInteger)index;

- (void)multiLevelDropDownMenu:(OKBMultiLevelMenuView *)dropDownMenu
          didSelectInTableView:(id<OKBMultiLevelMenuProtocol>)model;

@end

@interface OKBMultiLevelMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num widthWeight:(nullable NSString *)intColonInt;

@property (nonatomic, strong) id<OKBMultiLevelMenuViewDelegate> delegate;

- (void)reloadDataWithRootDataSource:(id<OKBMultiLevelMenuProtocol>)rootDataSource;

- (UITableView *)tableViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
