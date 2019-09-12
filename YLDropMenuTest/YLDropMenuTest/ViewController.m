//
//  ViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "OKBDropMenuView.h"
#import "OKBDropMenuItemView.h"
#import "LabelImageView.h"
#import "PersonModel.h"
#import "OKBMultiLevelDropDownMenuView.h"
#import <Masonry/Masonry.h>

@interface ViewController () <OKBDropMenuViewDataSource, OKBDropMenuViewDelegate, OKBMultiLevelDropDownMenuViewDelegate>
@property (nonatomic, strong) OKBDropMenuView *dropDownMenu;
@property (nonatomic, strong) OKBMultiLevelDropDownMenuView *eosDropDownMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dropDownMenu];
    
    [self.dropDownMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    

    
    
    
}

- (NSInteger)numberOfItemsInDropView:(OKBDropMenuView *)dropMenuView {
    return 4;
}

- (nullable OKBDropMenuItemView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewForItemAtIndex:(NSInteger)index {
    LabelImageView *tmp = [[LabelImageView alloc] initWithFrame:CGRectZero];
    if (index == 3) {
        tmp.image = [UIImage imageNamed:@"icon_setting"];
    }
    return tmp;
}

- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    if (index == 0) {
        return 10;
    } else if (index == 1) {
        return 20;
    } else {
        return 0;
    }
}

- (UIView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewInItemAtIndex:(NSInteger)index {
    UIView *tmp = [[UIView alloc] initWithFrame:CGRectZero];
    if (index == 0) {
        NSMutableArray *persons = NSMutableArray.new;
        for (int i = 0; i < 10; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"BeiJing";
            tmp.nodeName = tmp.address;
            [persons addObject:tmp];
        }
        
        NSMutableArray *companies = NSMutableArray.new;
        for (int i = 0; i < 3; i++) {
            CompanyModel *tmp = [[CompanyModel alloc] init];
            tmp.bossName = @"MaYun";
            tmp.array = persons;
            tmp.nodeName = tmp.bossName;
            [companies addObject:tmp];
        }
        
        NSMutableArray<DistrictModel *> *district = NSMutableArray.new;
        for (int i = 0; i < 5; i++) {
            DistrictModel *tmp = [[DistrictModel alloc] init];
            tmp.district = @"HaiDian";
            tmp.array = companies;
            tmp.nodeName = tmp.district;
            [district addObject:tmp];
        }
        
        PersonModel *p = [[PersonModel alloc] init];
        p.array = district;
        
        OKBMultiLevelDropDownMenuView *view = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:3];
        view.delegate = self;
        [view reloadDataWithDataSource:p];
        self.eosDropDownMenu = view;
        return view;
    }
    else if (index == 1) {
        NSMutableArray *persons = NSMutableArray.new;
        for (int i = 0; i < 10; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"BeiJing";
            tmp.nodeName = tmp.address;
            [persons addObject:tmp];
        }
        
        NSMutableArray *companies = NSMutableArray.new;
        for (int i = 0; i < 3; i++) {
            CompanyModel *tmp = [[CompanyModel alloc] init];
            tmp.bossName = @"MaYun";
            tmp.array = persons;
            tmp.nodeName = tmp.bossName;
            [companies addObject:tmp];
        }
        
        PersonModel *p = [[PersonModel alloc] init];
        p.array = companies;
        
        OKBMultiLevelDropDownMenuView *view = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:2];
        [view reloadDataWithDataSource:p];
        return view;
    } else if (index == 2) {
        NSMutableArray *persons = NSMutableArray.new;
        for (int i = 0; i < 10; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"BeiJing";
            tmp.nodeName = tmp.address;
            [persons addObject:tmp];
        }
        
        PersonModel *p = [[PersonModel alloc] init];
        p.array = persons;
        
        OKBMultiLevelDropDownMenuView *view = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:1];
        [view reloadDataWithDataSource:p];
        return view;
    } else if (index == 3) {
        tmp.backgroundColor = [UIColor blueColor];
    }
    return tmp;
}

- (CGFloat)dropMenuView:(OKBDropMenuView *)dropMenuView heightForViewAtIndexPath:(NSInteger)index {
    return 160;
}

- (void)dropMenuView:(OKBDropMenuView *)dropMenuView didSelectItemAtIndexPath:(NSInteger)index {
    NSLog(@"select index %d", index);
}

- (OKBDropMenuView *)dropDownMenu {
    if (!_dropDownMenu) {
        OKBDropMenuView *tmp = [[OKBDropMenuView alloc] initWithFrame:CGRectZero];
        tmp.delegate = self;
        tmp.dataSource = self;
        _dropDownMenu = tmp;
    }
    return _dropDownMenu;
}


@end
