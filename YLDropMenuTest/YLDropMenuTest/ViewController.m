//
//  ViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "OKBMenuView.h"
#import "OKBMenuItemView.h"
#import "LabelImageView.h"
#import "PersonModel.h"
#import "OKBMultiLevelDropDownMenuView.h"
#import <Masonry/Masonry.h>

@interface ViewController () <OKBMenuViewDataSource, OKBMenuViewDelegate, OKBMultiLevelDropDownMenuViewDelegate>
@property (nonatomic, strong) OKBMenuView *dropDownMenu;
@property (nonatomic, strong) PersonModel *dataSource;
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

#pragma mark - OKBMenuViewDataSource && OKBMenuViewDelegate

- (NSInteger)numberOfItemsInDropView:(OKBMenuView *)menuView {
    return 4;
}

- (nullable OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index {
    LabelImageView *tmp = [[LabelImageView alloc] initWithFrame:CGRectZero];
    if (index == 3) {
        tmp.image = [UIImage imageNamed:@"icon_setting"];
    }
    return tmp;
}

- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index {
    UIView *tmp = [[UIView alloc] initWithFrame:CGRectZero];
    if (index == 0) {
        NSMutableArray *persons = NSMutableArray.new;
        for (int i = 0; i < 10; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"LIUQIANGDONG";
            tmp.nodeName = tmp.address;
            [persons addObject:tmp];
        }
        
        NSMutableArray *persons2 = NSMutableArray.new;
        for (int i = 0; i < 6; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"LIYANHONG";
            tmp.nodeName = tmp.address;
            [persons2 addObject:tmp];
        }
        
        NSMutableArray *companies = NSMutableArray.new;
        for (int i = 0; i < 3; i++) {
            CompanyModel *tmp = [[CompanyModel alloc] init];
            tmp.bossName = [NSString stringWithFormat:@"JINGDONG %zd", i];;
            if (i == 0) {
                tmp.array = persons;
            }
            else {
                tmp.array = persons2;
            }
            tmp.nodeName = tmp.bossName;
            [companies addObject:tmp];
        }
        
        NSMutableArray *companies2 = NSMutableArray.new;
        for (int i = 0; i < 1; i++) {
            CompanyModel *tmp = [[CompanyModel alloc] init];
            tmp.bossName = [NSString stringWithFormat:@"BAIDU %zd", i];;
            tmp.array = persons2;
            tmp.nodeName = tmp.bossName;
            [companies2 addObject:tmp];
        }
        
        NSMutableArray<DistrictModel *> *district = NSMutableArray.new;
        for (int i = 0; i < 2; i++) {
            DistrictModel *tmp = [[DistrictModel alloc] init];
            tmp.district = [NSString stringWithFormat:@"HAIDIAN %zd", i];
            if (i == 0) {
                tmp.array = companies;
            }
            else {
                tmp.array = companies2;
            }
            tmp.nodeName = tmp.district;
            [district addObject:tmp];
        }
        
        PersonModel *p = [[PersonModel alloc] init];
        p.array = district;
        
        self.dataSource = p;
        
        OKBMultiLevelDropDownMenuView *view = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:3];
        view.delegate = self;
        [view reloadDataWithDataSource:p];
        UITableView *firstTableView = [view tableViewAtIndex:0];
        firstTableView.backgroundColor = [UIColor grayColor];
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

- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index {
    return 160;
}

- (void)menuView:(OKBMenuView *)menuView didSelectItemAtIndexPath:(NSInteger)index {
    NSLog(@"select index %d", index);
}

#pragma mark - OKBMultiLevelDropDownMenuViewDelegate

- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    if (index == 0) {
        return 32;
    } else if (index == 1) {
        return 32;
    } else {
        return 32;
    }
}

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu didSelectInTableView:(UITableView *)tableView atIndex:(NSInteger)index row:(NSInteger)row {
    if (index == 0) {
        DistrictModel *tmp = self.dataSource.array[row];
    }
}

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:12];
    tmp.textColor = [UIColor colorWithRed:153 green:153 blue:153 alpha:1];
    tmp.backgroundColor = [UIColor colorWithRed:247 green:248 blue:250 alpha:1];
    if (index == 0) {
        tmp.text = @"标的";
    } else if (index == 1) {
        tmp.text = @"到期时间";
    } else {
        tmp.text = @"价格";
    }
    return tmp;
}

#pragma mark - lazy load

- (OKBMenuView *)dropDownMenu {
    if (!_dropDownMenu) {
        OKBMenuView *tmp = [[OKBMenuView alloc] initWithFrame:CGRectZero];
        tmp.delegate = self;
        tmp.dataSource = self;
        _dropDownMenu = tmp;
    }
    return _dropDownMenu;
}


@end
