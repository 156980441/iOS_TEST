//
//  DataSourceFactory.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "DataSourceFactory.h"
#import "OKBMultiLevelMenuNode.h"
#import "PersonModel.h"

@implementation DataSourceFactory

+ (OKBMultiLevelMenuNode *)level3DataSource {
    
    OKBMultiLevelMenuNode *tmp = [OKBMultiLevelMenuNode defaultRootModel];
    
    NSMutableArray<OKBMultiLevelMenuNode *> *personsLevel3 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelMenuNode *> *persons2Level3 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelMenuNode *> *companiesLevel2 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelMenuNode *> *companies2Level2 = NSMutableArray.new;
    NSMutableArray<OKBMultiLevelMenuNode *> *districtLevel1 = NSMutableArray.new;
    
    for (int i = 0; i < 5; i++) {
        // 模拟服务器数据
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"刘强东 %d", i];
        
        // 构造 UI model
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.address;
        node.data = tmp;
        node.nodeId = i;
        [personsLevel3 addObject:node];
    }
    
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"李彦宏 %d", i];
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.address;
        node.data = tmp;
        node.nodeId = i;
        [persons2Level3 addObject:node];
    }
    
    
    for (int i = 0; i < 3; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"京东 %d", i];
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.bossName;
        node.data = tmp;
        node.nodeId = i;
        
        if (i == 0) {
            for (OKBMultiLevelMenuNode *person in personsLevel3) {
                [node insertChild:person];
            }
        }
        else {
            for (OKBMultiLevelMenuNode *person in persons2Level3) {
                [node insertChild:person];
            }
        }
        
        [companiesLevel2 addObject:node];
    }
    
    
    for (int i = 0; i < 1; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"百度 %d", i];;
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.bossName;
        node.data = tmp;
        node.nodeId = i;
        
        for (OKBMultiLevelMenuNode *person in persons2Level3 ) {
            [node insertChild:person];
        }
        
        [companies2Level2 addObject:node];
    }
    
    
    for (int i = 0; i < 2; i++) {
        
        DistrictModel *tmp = [[DistrictModel alloc] init];
        if (i == 0) {
            
            tmp.district = [NSString stringWithFormat:@"亦庄 %d", i];
            
            OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
            node.nodeName = tmp.district;
            node.data = tmp;
            node.nodeId = i;
            
            for (OKBMultiLevelMenuNode *company in companiesLevel2) {
                [node insertChild:company];
            }
            [districtLevel1 addObject:node];
        }
        else {
            
            tmp.district = [NSString stringWithFormat:@"海淀 %d", i];
            
            OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
            node.nodeName = tmp.district;
            node.data = tmp;
            
            for (OKBMultiLevelMenuNode *company in companies2Level2) {
                [node insertChild:company];
            }
            [districtLevel1 addObject:node];
        }
        
        
    }
    
    for (OKBMultiLevelMenuNode *company in districtLevel1) {
        [tmp insertChild:company];
    }
    
    return tmp;
}

+ (OKBMultiLevelMenuNode *)level1DataSource {
    
    OKBMultiLevelMenuNode *tmp = [OKBMultiLevelMenuNode defaultRootModel];
    
    NSMutableArray<OKBMultiLevelMenuNode *> *persons = NSMutableArray.new;
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"马云 %d", i];;
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.address;
        node.nodeId = i;
        [persons addObject:node];
    }
    
    for (OKBMultiLevelMenuNode *person in persons) {
        [tmp insertChild:person];
    }
    
    return tmp;
}

+ (OKBMultiLevelMenuNode *)level2DataSource {
    
    OKBMultiLevelMenuNode *tmp = [OKBMultiLevelMenuNode defaultRootModel];
    
    NSMutableArray<OKBMultiLevelMenuNode *> *persons = NSMutableArray.new;
    
    for (int i = 0; i < 10; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"北京-海淀-上地 %d 号院", i];
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.data = tmp;
        node.nodeName = tmp.address;
        node.nodeId = i;
        [persons addObject:node];
    }
    
    NSMutableArray<OKBMultiLevelMenuNode *> *companies = NSMutableArray.new;
    for (int i = 0; i < 3; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"马云 %d", i];
        
        OKBMultiLevelMenuNode *node = [[OKBMultiLevelMenuNode alloc] init];
        node.nodeName = tmp.bossName;
        node.data = tmp;
        node.nodeId = i;
        
        for (OKBMultiLevelMenuNode *person in persons) {
            [node insertChild:person];
        }

        [companies addObject:node];
    }
    
    for (OKBMultiLevelMenuNode *company in companies) {
        [tmp insertChild:company];
    }
    
    return tmp;
}



@end
