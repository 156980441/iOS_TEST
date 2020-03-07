//
//  ViewController.m
//  TreeDemo
//
//  Created by fanyl on 2020/3/3.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"

#import "Currency.h"
#import "CurrencyPair.h"
#import "TreeNode.h"

#import "BinaryTreeNode.h"

@interface ViewController ()
{
    NSArray<Currency *> *_currencies;
    NSArray<CurrencyPair *> *_currencyPairs;
    TreeNode *_ptree;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadFile];
    [self createBinaryTree];
}



- (void)createBinaryTree {
//    BinaryTreeNode *root = [[BinaryTreeNode alloc] initWithDataType:@"root"];
//    BinaryTreeNode *root_currency = [[BinaryTreeNode alloc] initWithDataType:_currencies.firstObject];
//    for (Currency *currency in _currencies) {
//        if (currency == _currencies.firstObject) {
//            BinaryTreeNode *root_filterWord = [[BinaryTreeNode alloc] initWithDataType:currency.filterWord.firstObject];
//            for (NSString *group in currency.filterWord) {
//                if (group == currency.filterWord.firstObject) {
//                    continue;
//                }
//                [BinaryTreeNode insertRightNode:root_filterWord data:currency];
//            }
//            [BinaryTreeNode insertLeftNode:root_filterWord data:root_filterWord.dataType];
//            continue;
//        }
//        [BinaryTreeNode insertRightNode:root_currency data:currency];
//
//    }
    
    BinaryTreeNode *currencyBiTree = [self p_func:_currencies];
    [BinaryTreeNode dlr:currencyBiTree
                  block:^(Currency *dataType) {
        NSLog(@"%@", dataType.groupName);
    }];
    NSLog(@"========");
    
    BinaryTreeNode *groupBiTree = [self p_func:_currencies.firstObject.filterWord];
    [BinaryTreeNode dlr:groupBiTree
                  block:^(NSString *dataType) {
        NSLog(@"%@", dataType);
    }];
    NSLog(@"========");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [BinaryTreeNode dlr:currencyBiTree
                  block:^(Currency *dataType) {
        BinaryTreeNode *node = [self p_func:dataType.filterWord];
        [dic setValue:node forKey:dataType.groupName];
    }];
}

- (BinaryTreeNode *)p_func:(NSArray *)arr {
    BinaryTreeNode *cursor, *root;
    cursor = root = [[BinaryTreeNode alloc] initWithDataType:arr.firstObject];
    for (id dataType in arr) {
        if (dataType == arr.firstObject) {
            continue;
        }
        cursor = [BinaryTreeNode insertRightNode:cursor data:dataType];
    }
    return root;
}

- (void)createChildSiblingTreeByPTree:(TreeNode *)ptree {
    
    TreeNode *parent;
    
    // 孩子兄弟表示法，普通树存储为二叉树结构
    TreeNode *node0 = [[TreeNode alloc] init];
    node0.data = ptree.data;
    node0.firstChild = nil;
    node0.nextSibling = nil;
    
    parent = ptree.parent;
    
    if (parent != nil) {
        
    }
    
    TreeNode *firstChildNode = [[TreeNode alloc] init];
    TreeNode *nextSiblingNode = [[TreeNode alloc] init];
    
    firstChildNode.data = _currencies.firstObject.filterWord.firstObject;
    
    node0.firstChild = firstChildNode;
    node0.nextSibling = nextSiblingNode;
}


/// PTree
- (void)createParentTree {
    // 搭建树，双亲表示法
    
    TreeNode *node0 = [[TreeNode alloc] init];
    node0.parent = nil;
    node0.data = @"根节点";
    
    NSMutableArray *child0 = [NSMutableArray array];
    for (Currency *tmp in _currencies) {
        TreeNode *node1 = [[TreeNode alloc] init];
        node1.parent = node0;
        node1.data = tmp;
        [child0 addObject:node1]; // 根节点添加子节点
        
        NSMutableArray *child1 = [NSMutableArray array];
        for (NSString *str in tmp.filterWord) {
            TreeNode *node2 = [[TreeNode alloc] init];
            node2.parent = node1;
            node2.data = str;
            [child1 addObject:node2]; // 一级结点添加二级结点
            
            NSMutableArray *child2 = [NSMutableArray array];
            for (CurrencyPair *pairs in _currencyPairs) {
                if ([[pairs.symbol componentsSeparatedByString:@"_"].lastObject isEqualToString:str]) {
                    TreeNode *node3 = [[TreeNode alloc] init];
                    node3.parent = node2;
                    node3.data = pairs;
                    [child2 addObject:node3]; // 二级结点添加三级结点
                }
            }
            node2.children = child2;
        }
        
        node1.children = child1;
    }
    
    node0.children = child0;
    
    _ptree = node0;
}

- (void)display:(TreeNode *)node {
    
}

// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)loadFile {
    NSDictionary *dic1 = [self readLocalFileWithName:@"tree"];
    NSDictionary *dic2 = [self readLocalFileWithName:@"tree2"];
    
    NSArray<Currency *> *currencies = [Currency mj_objectArrayWithKeyValuesArray:dic1[@"data"]];
    
    NSArray<CurrencyPair *> *currencyPairs = [CurrencyPair mj_objectArrayWithKeyValuesArray:dic2[@"data"]];
    
    _currencies = currencies;
    _currencyPairs = currencyPairs;
    
    [_currencies sortedArrayUsingComparator:^NSComparisonResult(Currency *obj1, Currency *obj2) {
        if (obj1.sort.intValue < obj2.sort.intValue) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
}


@end
