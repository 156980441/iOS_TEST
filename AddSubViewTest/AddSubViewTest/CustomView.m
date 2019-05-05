//
//  CustomView.m
//  AddSubViewTest
//
//  Created by fanyl on 2019/5/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)layoutSubviews {
    NSLog(@"%s", __func__);
//    NSArray *syms = [NSThread  callStackSymbols];
//    if ([syms count] > 1) {
//        NSLog(@"<%@ %p> %@ - caller: %@ ", [self class], self, NSStringFromSelector(_cmd), syms);
//    } else {
//        NSLog(@"<%@ %p> %@", [self class], self, NSStringFromSelector(_cmd));
//    }
}

@end
