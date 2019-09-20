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


@class OKBMultiLevelDropDownMenuView;

@protocol OKBMultiLevelDropDownMenuViewDelegate <NSObject>

@optional
- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu
       heightForHeaderInTableView:(UITableView *)tableView
                          atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu
                   viewForHeaderInTableView:(UITableView *)tableView
                                    atIndex:(NSInteger)index;

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu
          didSelectInTableView:(id<OKBMultiLevelMenuProtocol>)model;

@end

@interface OKBMultiLevelDropDownMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num widthWeight:(NSString *)intColonInt;

@property (nonatomic, strong) id<OKBMultiLevelDropDownMenuViewDelegate> delegate;

- (void)reloadDataWithRootDataSource:(id<OKBMultiLevelMenuProtocol>)rootDataSource;

- (UITableView *)tableViewAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
