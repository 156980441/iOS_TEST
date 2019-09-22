//
//  OKBMultiLevelDropDownMenuVC.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuItemViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelDropDownMenuRootModel, OKBMultiLevelDropMenuTVHeaderView;
@protocol OKBMultiLevelMenuProtocol;

@interface OKBMultiLevelDropDownMenuVC : OKBMenuItemViewController

- (instancetype)initWithMultiLevel:(NSInteger)levels
                levelOfWidthWeight:(nullable NSString *)intColonInt
               tableViewHeaders:(NSArray<OKBMultiLevelDropMenuTVHeaderView *> *)headerViews
                         rootModel:(OKBMultiLevelDropDownMenuRootModel *)model
                             block:(nullable void (^)(id<OKBMultiLevelMenuProtocol>model))block;

@property (nonatomic, copy, nullable) void (^selectedBlock)(id<OKBMultiLevelMenuProtocol>model);

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
