//
//  DataSourceFactory.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "DataSourceFactory.h"
#import "OKBMultiLevelDropDownMenuRootModel.h"
#import "PersonModel.h"

@implementation DataSourceFactory

+ (OKBMultiLevelDropDownMenuRootModel *)level3DataSource {
    OKBMultiLevelDropDownMenuRootModel *tmp = [OKBMultiLevelDropDownMenuRootModel defaultRootModel];
    
    NSMutableArray<PersonModel *> *personsLevel3 = NSMutableArray.new;
    NSMutableArray<PersonModel *> *persons2Level3 = NSMutableArray.new;
    NSMutableArray<CompanyModel *> *companiesLevel2 = NSMutableArray.new;
    NSMutableArray<CompanyModel *> *companies2Level2 = NSMutableArray.new;
    NSMutableArray<DistrictModel *> *districtLevel1 = NSMutableArray.new;
    
    for (int i = 0; i < 5; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"刘强东 %d", i];
        tmp.nodeName = tmp.address;
        tmp.nodeId = i;
        [personsLevel3 addObject:tmp];
    }
    
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = [NSString stringWithFormat:@"李彦宏 %d", i];
        tmp.nodeName = tmp.address;
        [persons2Level3 addObject:tmp];
    }
    
    
    for (int i = 0; i < 3; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"京东 %d", i];;
        if (i == 0) {
            tmp.array = personsLevel3;
            for (PersonModel *person in tmp.array) {
                person.parent = tmp;
            }
        }
        else {
            tmp.array = personsLevel3;
            for (PersonModel *person in tmp.array) {
                person.parent = tmp;
            }
        }
        tmp.nodeName = tmp.bossName;
        [companiesLevel2 addObject:tmp];
    }
    
    
    for (int i = 0; i < 1; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = [NSString stringWithFormat:@"百度 %d", i];;
        tmp.array = persons2Level3;
        for (PersonModel *person in tmp.array) {
            person.parent = tmp;
        }
        tmp.nodeName = tmp.bossName;
        [companies2Level2 addObject:tmp];
    }
    
    
    for (int i = 0; i < 2; i++) {
        DistrictModel *tmp = [[DistrictModel alloc] init];
        if (i == 0) {
            tmp.district = [NSString stringWithFormat:@"亦庄 %d", i];
            tmp.array = companiesLevel2;
            for (CompanyModel *company in tmp.array) {
                company.parent = tmp;
            }
        }
        else {
            tmp.district = [NSString stringWithFormat:@"海淀 %d", i];
            tmp.array = companies2Level2;
            for (CompanyModel *company in tmp.array) {
                company.parent = tmp;
            }
        }
        tmp.nodeName = tmp.district;
        [districtLevel1 addObject:tmp];
    }
    
    tmp.array = districtLevel1;
    
    return tmp;
}

+ (OKBMultiLevelDropDownMenuRootModel *)level1DataSource {
    OKBMultiLevelDropDownMenuRootModel *tmp = [OKBMultiLevelDropDownMenuRootModel defaultRootModel];
    
    NSMutableArray *persons = NSMutableArray.new;
    for (int i = 0; i < 2; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = @"马云";
        tmp.nodeName = tmp.address;
        [persons addObject:tmp];
    }
    
    tmp.array = persons;
    
    return tmp;
}

+ (OKBMultiLevelDropDownMenuRootModel *)level2DataSource {
    
    OKBMultiLevelDropDownMenuRootModel *tmp = [OKBMultiLevelDropDownMenuRootModel defaultRootModel];
    
    NSMutableArray *persons = NSMutableArray.new;
    for (int i = 0; i < 10; i++) {
        PersonModel *tmp = [[PersonModel alloc] init];
        tmp.address = @"北京";
        tmp.nodeName = tmp.address;
        [persons addObject:tmp];
    }
    
    NSMutableArray *companies = NSMutableArray.new;
    for (int i = 0; i < 3; i++) {
        CompanyModel *tmp = [[CompanyModel alloc] init];
        tmp.bossName = @"马云";
        tmp.array = persons;
        tmp.nodeName = tmp.bossName;
        [companies addObject:tmp];
    }
    
    tmp.array = companies;
    
    return tmp;
}



@end
