//
//  OKBMultiLevelDropDownMenuVC.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelDropDownMenuRootModel;
@protocol OKBMultiLevelMenuProtocol;

@interface OKBMultiLevelDropDownMenuVC : UIViewController

- (instancetype)initWithMultiLevel:(NSInteger)levels
                levelOfWidthWeight:(nullable NSString *)intColonInt
                         rootModel:(OKBMultiLevelDropDownMenuRootModel *)model
                             block:(nullable void (^)(id<OKBMultiLevelMenuProtocol>model))block;

@property (nonatomic, copy, nullable) void (^selectedBlock)(id<OKBMultiLevelMenuProtocol>model);

@end

NS_ASSUME_NONNULL_END
