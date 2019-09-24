//
//  OKBMultiLevelMenuNode.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuNode.h"


@interface OKBMultiLevelMenuNode ()
{
    NSMutableArray<OKBMultiLevelMenuNode *> *_childrenArr;
    NSArray<OKBMultiLevelMenuNode *> *_childNodes;
}
@end

@implementation OKBMultiLevelMenuNode

+ (instancetype)defaultRootModel {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setParentNode:nil];
        [self setChildNodes:nil];
        _nodeName = @"";
        _nodeId = -1;
        _childrenArr = [NSMutableArray array];
    }
    return self;
}

- (void)setChildNodes:(NSArray<OKBMultiLevelMenuNode *> * _Nullable)childNodes {
    _childNodes = childNodes;
}

- (void)setParentNode:(OKBMultiLevelMenuNode * _Nullable)parentNode {
    _parentNode = parentNode;
}

- (void)insertChild:(OKBMultiLevelMenuNode *)childNode {
    [childNode setParentNode:self];
    [self->_childrenArr addObject:childNode];
}

- (void)deleteChild:(OKBMultiLevelMenuNode *)childNode {
    [childNode setParentNode:self];
    [self->_childrenArr removeObject:childNode];
}

- (NSArray<OKBMultiLevelMenuNode *> *)childNodes {
    _childNodes = [NSArray arrayWithArray:_childrenArr];
    if (_childNodes.count > 0) {
        return _childNodes;
    }
    else {
        return nil;
    }
}

@end
