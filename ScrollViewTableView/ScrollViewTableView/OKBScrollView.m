//
//  OKBScrollView.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBScrollView.h"

@implementation OKBScrollView

// 返回YES，则可以多个手势一起触发方法，返回 NO 则为互斥（比如外层 UIScrollView 名为 mainScroll 内嵌的 UIScrollView 名为 subScroll，当我们拖动subScroll时，mainScroll是不会响应手势的（多个手势默认是互斥的），当下面这个代理返回YES时，subScroll和mainScroll就能同时响应手势，同时滚动，这符合我们这里的需求）
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        return YES;
    }
    else
    {
        return  NO;
    }
}

@end
