//
//  OKBMultiLevelMenuUtil.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuUtil.h"

@implementation OKBMultiLevelMenuUtil

+ (OKBMultiLevelMenuNode *)search:(OKBMultiLevelMenuNode *)source withNodeId:(NSInteger)nodeId {
    if (source.nodeId == nodeId) {
        return source;
    }
    else {
        NSArray<OKBMultiLevelMenuNode *> *arr = source.childNodes;
        for (OKBMultiLevelMenuNode *tmp in arr) {
            if (tmp.nodeId == nodeId) {
                return tmp;
            }
            else {
                OKBMultiLevelMenuNode *result = [self search:tmp withNodeId:nodeId];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}

@end
