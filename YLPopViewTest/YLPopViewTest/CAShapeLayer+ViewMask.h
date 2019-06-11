//
//  CAShapeLayer+ViewMask.h
//  YLPopViewTest
//
//  Created by fanyl on 2019/6/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (ViewMask)
+ (instancetype)createMaskLayerWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
