//
//  OKBMultiLevelMenuUtil.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuUtil.h"

@implementation OKBMultiLevelMenuUtil

+ (id<OKBMultiLevelMenuProtocol>)search:(id<OKBMultiLevelMenuProtocol>)source withNodeId:(NSInteger)nodeId {
    if (source.nodeId == nodeId) {
        return source;
    }
    else {
        NSArray<id<OKBMultiLevelMenuProtocol>> *arr = source.array;
        for (id<OKBMultiLevelMenuProtocol> tmp in arr) {
            if (tmp.nodeId == nodeId) {
                return tmp;
            }
            else {
                id<OKBMultiLevelMenuProtocol> result = [self search:tmp withNodeId:nodeId];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}

@end
