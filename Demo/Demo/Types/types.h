//
//  types.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#ifndef types_h
#define types_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Label 水平或者竖直
 */
typedef NS_ENUM(NSInteger, YLLabelsViewLayoutDirection) {
    YLLabelsViewLayoutDirection_horizontal = 1, // 水平
    YLLabelsViewLayoutDirection_vertical  = 2   // 竖直
};


/**
 Label 的吸附方式
 */
typedef NS_ENUM(NSInteger, YLLabelsViewLayoutAlignment) {
    YLLabelsViewLayoutAlignmentLeft      = 0, // 左吸附
    YLLabelsViewLayoutAlignmentCenter    = 1, // 居中
    YLLabelsViewLayoutAlignmentRight     = 2, // 右吸附
    YLLabelsViewLayoutAlignmentExpand    = 3, // 两边吸附
};

#endif /* types_h */
