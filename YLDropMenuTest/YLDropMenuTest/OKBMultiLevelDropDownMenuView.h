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
- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index;

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index;

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu didSelectInTableView:(UITableView *)tableView atIndex:(NSInteger)index row:(NSInteger)row;

@end

@interface OKBMultiLevelDropDownMenuView : UIView
- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num;
@property (nonatomic, strong) id<OKBMultiLevelDropDownMenuViewDelegate> delegate;
- (void)reloadDataWithDataSource:(id<OKBMultiLevelMenuProtocol>)dataSource;
- (UITableView *)tableViewAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
