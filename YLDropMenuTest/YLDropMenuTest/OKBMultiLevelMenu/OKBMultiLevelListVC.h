//
//  OKBMultiLevelDropDownMenuVC.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuItemViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelMenuRootModel, OKBMultiLevelListColumnHeaderView, OKBMultiLevelListNode;

@interface OKBMultiLevelListColumnConfig : NSObject

@property (nonatomic, assign) NSInteger widthWeight;
@property (nonatomic, strong, nullable) OKBMultiLevelListColumnHeaderView *columnHeaderView;
@property (nonatomic, strong) Class customTVCellClass;

@end


@interface OKBMultiLevelListVC : OKBMenuItemViewController

- (instancetype)initWithConfig:(NSArray<OKBMultiLevelListColumnConfig *> *)configs
                     rootModel:(OKBMultiLevelListNode *)model
                         block:(nullable void (^)(OKBMultiLevelListNode *model))block;

- (instancetype)initSingleListWithConfig:(OKBMultiLevelListColumnConfig *)config
                               listNodes:(NSArray<OKBMultiLevelListNode *> *)nodes
                                   block:(nullable void (^)(OKBMultiLevelListNode *model))block;

@property (nonatomic, copy, nullable) void (^selectedBlock)(OKBMultiLevelListNode *model);

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
