//
//  OKBMultiLevelDropDownMenuVC.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuItemViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelMenuRootModel, OKBMultiLevelMenuTVHeaderView, OKBMultiLevelMenuNode;

@interface OKBMultiLevelMenuVC : OKBMenuItemViewController

- (instancetype)initWithMultiLevel:(NSInteger)levels
                levelOfWidthWeight:(nullable NSString *)intColonInt
                  tableViewHeaders:(NSArray<OKBMultiLevelMenuTVHeaderView *> *)headerViews
                         rootModel:(OKBMultiLevelMenuNode *)model
                             block:(nullable void (^)(OKBMultiLevelMenuNode *model))block;

@property (nonatomic, copy, nullable) void (^selectedBlock)(OKBMultiLevelMenuNode *model);

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
