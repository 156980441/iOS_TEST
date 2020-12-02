//
//  OKBNestedScrollView.m
//  scrollview_tableview
//
//  Created by fanyl on 2020/12/1.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "OKBNestedScrollView.h"

@implementation OKBNestedScrollView

// 是否支持多时候触发，这里返回 YES，默认 NO
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
