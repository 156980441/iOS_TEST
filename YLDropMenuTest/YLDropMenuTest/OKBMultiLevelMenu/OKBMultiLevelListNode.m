//
//  OKBMultiLevelMenuNode.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListNode.h"


@interface OKBMultiLevelListNode ()
{
    NSMutableArray<OKBMultiLevelListNode *> *_childrenArr;
    NSArray<OKBMultiLevelListNode *> *_childNodes;
}
@end

@implementation OKBMultiLevelListNode

+ (instancetype)defaultRootModel {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setParentNode:nil];
        [self setChildNodes:nil];
        _nodeName = @"";
//        _nodeId = -1;
        _childrenArr = [NSMutableArray array];
    }
    return self;
}

+ (OKBMultiLevelListNode *)searchNodeByNodeName:(NSString *)name rootNode:(OKBMultiLevelListNode *)rootNode {
    if (name == nil) {
        return nil;
    }
    OKBMultiLevelListNode *result = nil;
    if ([rootNode.nodeName isEqualToString:name]) {
        result = rootNode;
    }
    else {
        for (OKBMultiLevelListNode *tmp in rootNode.childNodes) {
            if ([tmp.nodeName isEqualToString:name]) {
                result = tmp;
                break;
            }
            else {
                result = [self searchNodeByNodeName:name rootNode:tmp];
                if (!result) {
                    continue;
                }
                else {
                    break;
                }
            }
        }
    }
    
    return result;
}

- (void)setChildNodes:(NSArray<OKBMultiLevelListNode *> * _Nullable)childNodes {
    _childNodes = childNodes;
}

- (void)setParentNode:(OKBMultiLevelListNode * _Nullable)parentNode {
    _parentNode = parentNode;
}

- (void)addChild:(OKBMultiLevelListNode *)childNode {
    [childNode setParentNode:self];
    [self->_childrenArr addObject:childNode];
}

- (void)removeChild:(OKBMultiLevelListNode *)childNode {
    if ([self->_childrenArr containsObject:childNode]) {
        [self->_childrenArr removeObject:childNode];
        childNode.parentNode = nil;
    }
}

- (NSArray<OKBMultiLevelListNode *> *)childNodes {
    _childNodes = [NSArray arrayWithArray:_childrenArr];
    if (_childNodes.count > 0) {
        return _childNodes;
    }
    else {
        return nil;
    }
}

@end
