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

@interface OKBMultiLevelMenuViewConfig : NSObject

@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy, nullable) NSString *widthWeight;
@property (nonatomic, strong) NSArray<OKBMultiLevelMenuTVHeaderView *> *headerViews;

@end


@interface OKBMultiLevelMenuVC : OKBMenuItemViewController

- (instancetype)initWithConfig:(OKBMultiLevelMenuViewConfig *)config
                     rootModel:(OKBMultiLevelMenuNode *)model
                         block:(nullable void (^)(OKBMultiLevelMenuNode *model))block;

@property (nonatomic, copy, nullable) void (^selectedBlock)(OKBMultiLevelMenuNode *model);

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
