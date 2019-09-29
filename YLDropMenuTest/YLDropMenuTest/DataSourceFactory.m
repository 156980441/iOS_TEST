//
//  DataSourceFactory.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "DataSourceFactory.h"
#import "OKBMultiLevelListNode.h"
#import "PersonModel.h"

@implementation DataSourceFactory

+ (OKBMultiLevelListNode *)level3DataSource {
    
    OKBMultiLevelListNode *tmp = [OKBMultiLevelListNode defaultRootModel];
    
    NSMutableArray<OKBMultiLevelListNode *> *personsLevel3 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelListNode *> *persons2Level3 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelListNode *> *companiesLevel2 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelListNode *> *companies2Level2 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelListNode *> *districtLevel1 = NSMutableArray.new;
    
    for (int i = 0; i < 5; i++) {
        // 模拟服务器数据
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"刘强东 %d", i];
        
        // 构造 UI model
        OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
        node.nodeName = tmp.address;
        node.data = tmp;
//        node.nodeId = i;
        [personsLevel3 addObject:node];
    }
    
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"李彦宏 %d", i];
        
        OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
        node.nodeName = tmp.address;
        node.data = tmp;
//        node.nodeId = i;
        [persons2Level3 addObject:node];
    }
    
    
    for (int i = 0; i < 3; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"京东 %d", i];
        
        OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
        node.nodeName = tmp.bossName;
        node.data = tmp;
//        node.nodeId = i;
        
        if (i == 0) {
            for (OKBMultiLevelListNode *person in personsLevel3) {
                [node addChild:person];
            }
        }
        else {
            for (OKBMultiLevelListNode *person in persons2Level3) {
                [node addChild:person];
            }
        }
        
        [companiesLevel2 addObject:node];
    }
    
    
    for (int i = 0; i < 1; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"百度 %d", i];;
        
        OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
        node.nodeName = tmp.bossName;
        node.data = tmp;
//        node.nodeId = i;
        
        for (OKBMultiLevelListNode *person in persons2Level3 ) {
            [node addChild:person];
        }
        
        [companies2Level2 addObject:node];
    }
    
    
    for (int i = 0; i < 2; i++) {
        
        DistrictModel *tmp = [[DistrictModel alloc] init];
        if (i == 0) {
            
            tmp.district = [NSString stringWithFormat:@"亦庄 %d", i];
            
            OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
            node.nodeName = tmp.district;
            node.data = tmp;
//            node.nodeId = i;
            
            for (OKBMultiLevelListNode *company in companiesLevel2) {
                [node addChild:company];
            }
            [districtLevel1 addObject:node];
        }
        else {
            
            tmp.district = [NSString stringWithFormat:@"海淀 %d", i];
            
            OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
            node.nodeName = tmp.district;
            node.data = tmp;
            
            for (OKBMultiLevelListNode *company in companies2Level2) {
                [node addChild:company];
            }
            [districtLevel1 addObject:node];
        }
        
        
    }
    
    for (OKBMultiLevelListNode *company in districtLevel1) {
        [tmp addChild:company];
    }
    
    return tmp;
}

+ (OKBMultiLevelListNode *)level1DataSource {
    
    OKBMultiLevelListNode *tmp = [OKBMultiLevelListNode defaultRootModel];
    
    NSMutableArray<OKBMultiLevelListNode *> *persons = NSMutableArray.new;
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"马云 %d", i];;
        
        OKBMultiLevelListNode *node = [[OKBMultiLevelListNode alloc] init];
        node.nodeName = tmp.address;
//        node.nodeId = i;
        [persons addObject:node];
    }
    
    for (OKBMultiLevelListNode *person in persons) {
        [tmp addChild:person];
    }
    
    return tmp;
}

+ (OKBMultiLevelListNode *)level2DataSource {
    
    OKBMultiLevelListNode *root = [OKBMultiLevelListNode defaultRootModel]; // 根节点
    
    for (int i = 0; i < 3; i++) { // 第一层
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"马云 %d", i];
        
        OKBMultiLevelListNode *c_node = [[OKBMultiLevelListNode alloc] init];
        c_node.nodeName = tmp.bossName;
        c_node.data = tmp;
//        c_node.nodeId = i;
        
        [root addChild:c_node];
        
        for (int j = 0; j < 10; j++) { // 第二层
            PersonModel *person = [[PersonModel alloc] init];
            person.address = [NSString stringWithFormat:@"海淀-上地 %d 号院 %d 公寓", i, j];
            
            OKBMultiLevelListNode *p_node = [[OKBMultiLevelListNode alloc] init];
            p_node.data = tmp;
            p_node.nodeName = person.address;
//            p_node.nodeId = i;
            [c_node addChild:p_node];
        }

    }
    
    return root;
}



@end
