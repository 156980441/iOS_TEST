//
//  OKBMultiLevelMenuNode.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuNode.h"

@implementation OKBMultiLevelMenuNode

+ (instancetype)defaultRootModel {
    OKBMultiLevelMenuNode *tmp = [[OKBMultiLevelMenuNode alloc] init];
    tmp.parentNode = nil;
    tmp.nodeName = @"";
    tmp.childNodes = nil;
    tmp.nodeId = -1;
    return tmp;
}

@end
