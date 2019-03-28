//
//  PersonMonitor.m
//  KVO_KVC
//
//  Created by fanyunlong on 5/27/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "PersonMonitor.h"

@implementation PersonMonitor

//观察者需要实现的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"name"])
    {
        NSLog(@"change happen,old:%@ ,new:%@;context = %@",[change objectForKey:NSKeyValueChangeOldKey],[change objectForKey:NSKeyValueChangeNewKey],context);
    }
}

@end
