//
//  OKBMultiLevelMenuUtil.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuUtil.h"

@implementation OKBMultiLevelMenuUtil

+ (OKBMultiLevelListNode *)search:(OKBMultiLevelListNode *)source withNodeId:(NSInteger)nodeId {
    if (source.nodeId == nodeId) {
        return source;
    }
    else {
        NSArray<OKBMultiLevelListNode *> *arr = source.childNodes;
        for (OKBMultiLevelListNode *tmp in arr) {
            if (tmp.nodeId == nodeId) {
                return tmp;
            }
            else {
                OKBMultiLevelListNode *result = [self search:tmp withNodeId:nodeId];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}

@end
