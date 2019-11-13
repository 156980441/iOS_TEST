//
//  RootVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/13.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "RootVC.h"
#import "ScrollVC.h"
#import "HeaderViewVC.h"

@interface RootVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation RootVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 30);
        UICollectionView *tmp = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [tmp registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"Cell"];
        tmp.delegate = self;
        tmp.dataSource = self;
        [self.view addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        _collectionView = tmp;
        
        self.dataSource = @[@"Header view", @"Scroll view"];
    }
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc;
    if (indexPath.row == 0) {
        vc = [[HeaderViewVC alloc] init];
    }
    else {
        vc = [[ScrollVC alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    UILabel *tmp = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    tmp.text = self.dataSource[indexPath.row];
    [cell.contentView addSubview:tmp];
    return cell;
}

@end
