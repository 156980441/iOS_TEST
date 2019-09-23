//
//  OKBMultiLevelDropDownMenuRootModel.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/16.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuRootModel.h"

@implementation OKBMultiLevelMenuRootModel

+ (instancetype)defaultRootModel {
    OKBMultiLevelMenuRootModel *tmp = [[OKBMultiLevelMenuRootModel alloc] init];
    tmp.nodeId = -1;
    tmp.parent = nil;
    tmp.nodeName = @"";
    tmp.array = nil;
    return tmp;
}

@end
