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
#import "OKBMultiLevelDropDownMenuRootModel.h"
#import <Masonry/Masonry.h>

#import "OKBMenuViewController.h"
#import "OKBMultiLevelDropDownMenuVC.h"

@interface ViewController () <OKBMenuViewDataSource, OKBMenuViewDelegate, OKBMultiLevelDropDownMenuViewDelegate>
@property (nonatomic, strong) OKBMenuView *dropDownMenu;
@property (nonatomic, strong) OKBMultiLevelDropDownMenuView *item1SoureView;
@property (nonatomic, strong) OKBMultiLevelDropDownMenuRootModel *item1DataSource;
@property (nonatomic, strong) OKBMultiLevelDropDownMenuView *item3SoureView;
@property (nonatomic, strong) OKBMultiLevelDropDownMenuRootModel *item3DataSource;

@property (nonatomic, strong) OKBMenuViewController *menuVC;
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
    
    
    [self addChildViewController:self.menuVC];
    [self.view addSubview:self.menuVC.view];
    [self didMoveToParentViewController:self];
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
}

#pragma mark - OKBMenuViewDataSource && OKBMenuViewDelegate

- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView {
    return 4;
}

- (OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index {
    LabelImageView *tmp = [[LabelImageView alloc] initWithFrame:CGRectZero];
    if (index == 3) {
        tmp.image = [UIImage imageNamed:@"icon_setting"];
    }
    return tmp;
}

- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index {
    UIView *tmp = [[UIView alloc] initWithFrame:CGRectZero];
    if (index == 0) {
        return self.item1SoureView;
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
        [view reloadDataWithRootDataSource:p];
        return view;
    } else if (index == 2) {
        return self.item3SoureView;
    } else if (index == 3) {
        tmp.backgroundColor = [UIColor blueColor];
    }
    return tmp;
}

- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index {
    if (index == 0) {
        return 260;
    }
    else {
        return 160;
    }
}

- (void)menuView:(OKBMenuView *)menuView didSelectItemAtIndexPath:(NSInteger)index {
    
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

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu didSelectInTableView:(nonnull id<OKBMultiLevelMenuProtocol>)model {
    LabelImageView *tmp = (LabelImageView *)[self.dropDownMenu menuItemViewAtIndex:self.dropDownMenu.selectedItemIndex];
    tmp.textLbl.text = model.nodeName;
    [self.dropDownMenu dismissSourceViewWithAnimation:YES];
    if (model.nodeId == 3) {
        id<OKBMultiLevelMenuProtocol> original = model.parent.parent;
        original.array = self.item3DataSource.array;
    }
}

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:12];
    tmp.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
    tmp.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
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

- (OKBMultiLevelDropDownMenuView *)item1SoureView {
    if (!_item1SoureView) {
        OKBMultiLevelDropDownMenuView *tmp = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:3];
        tmp.delegate = self;
        [tmp reloadDataWithRootDataSource:self.item1DataSource];
        UITableView *firstTableView = [tmp tableViewAtIndex:1];
        firstTableView.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
        _item1SoureView = tmp;
    }
    return _item1SoureView;
}

- (OKBMultiLevelDropDownMenuRootModel *)item1DataSource {
    if (!_item1DataSource) {
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
        
        _item1DataSource = tmp;
    }
    return _item1DataSource;
}

- (OKBMultiLevelDropDownMenuView *)item3SoureView {
    if (!_item3SoureView) {
        OKBMultiLevelDropDownMenuView *tmp = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:1];
        [tmp reloadDataWithRootDataSource:self.item3DataSource];
        _item3SoureView = tmp;
    }
    return _item3SoureView;
}

- (OKBMultiLevelDropDownMenuRootModel *)item3DataSource {
    if (!_item3DataSource) {
        OKBMultiLevelDropDownMenuRootModel *tmp = [OKBMultiLevelDropDownMenuRootModel defaultRootModel];
        
        NSMutableArray *persons = NSMutableArray.new;
        for (int i = 0; i < 2; i++) {
            PersonModel *tmp = [[PersonModel alloc] init];
            tmp.address = @"马云";
            tmp.nodeName = tmp.address;
            [persons addObject:tmp];
        }
        
        tmp.array = persons;
        
        _item3DataSource = tmp;
    }
    return _item3DataSource;
}


- (OKBMenuViewController *)menuVC {
    if (!_menuVC) {
        OKBMultiLevelDropDownMenuVC *vc1 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:1];
        OKBMultiLevelDropDownMenuVC *vc2 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:2];
        OKBMenuViewController *tmp = [[OKBMenuViewController alloc] initWithMenuItemControllers:@[vc1, vc2]];
        _menuVC = tmp;
    }
    return _menuVC;
}

@end
