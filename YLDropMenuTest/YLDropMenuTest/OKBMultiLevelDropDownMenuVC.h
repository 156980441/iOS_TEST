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
@interface OKBMultiLevelDropDownMenuVC : UIViewController
- (instancetype)initWithMultiLevel:(NSInteger)levels rootModel:(OKBMultiLevelDropDownMenuRootModel *)model;
@end

NS_ASSUME_NONNULL_END
