//
//  OKBMultiLevelDropDownMenuRootModel.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/16.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelDropDownMenuRootModel.h"

@implementation OKBMultiLevelDropDownMenuRootModel

+ (instancetype)defaultRootModel {
    OKBMultiLevelDropDownMenuRootModel *tmp = [[OKBMultiLevelDropDownMenuRootModel alloc] init];
    tmp.nodeId = -1;
    tmp.parentId = -1;
    tmp.nodeName = @"";
    tmp.array = nil;
    return tmp;
}

@end
