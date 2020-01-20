//
//  StrategyFactory.m
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "StrategyFactory.h"
#import "LimitPriceStrategy.h"
#import "MarketPriceStrategyVC.h"

@implementation StrategyFactory

+ (AbsStrategyVC *)createStrategyVC:(StrategyVCType)type {
    // 未来使用策略再把 switch 干掉
    AbsStrategyVC *vc = nil;
    switch (type) {
        case StrategyVCTypeLimitPrice:
            vc = LimitPriceStrategy.new;
            break;
        case StrategyVCTypeMarketPrice:
            vc = MarketPriceStrategyVC.new;
            break;
        default:
            NSAssert(0, @"策略失败");
            break;
    }
    return vc;
}

@end
