//
//  OKBMultiLevelDropDownMenuVC.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelMenuRootModel, OKBMultiLevelListNode, OKBMultiLevelListColumnConfig;


/// 多级列表 VC
@interface OKBMultiLevelListVC : UIViewController

- (instancetype)initWithConfigs:(NSArray<OKBMultiLevelListColumnConfig *> *)configs
                      rootModel:(OKBMultiLevelListNode *)model;

- (instancetype)initSingleListWithConfig:(OKBMultiLevelListColumnConfig *)config
                               listNodes:(NSArray<OKBMultiLevelListNode *> *)nodes;

@property (nonatomic, copy, nullable) void (^selectedBlock)(OKBMultiLevelListNode *model);

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index;

- (void)setSelectedNode:(OKBMultiLevelListNode *)node;

@end

NS_ASSUME_NONNULL_END
