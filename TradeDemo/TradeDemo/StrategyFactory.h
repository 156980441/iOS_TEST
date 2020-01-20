//
//  StrategyFactory.h
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsStrategyVC.h"

// 参考文档：
// http://c.biancheng.net/view/1348.html
// https://www.runoob.com/design-pattern/factory-pattern.html

typedef NS_ENUM(NSUInteger, StrategyVCType) {
    StrategyVCTypeLimitPrice,
    StrategyVCTypeMarketPrice
};

NS_ASSUME_NONNULL_BEGIN

// 当需要生成的产品不多且不会增加，一个具体工厂类就可以完成任务时，可删除抽象工厂类。
@interface StrategyFactory : NSObject
+ (AbsStrategyVC *)createStrategyVC:(StrategyVCType)type;
@end

NS_ASSUME_NONNULL_END
