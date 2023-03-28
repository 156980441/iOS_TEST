//
//  CollectionHeaderVC.m
//  find_me
//
//  Created by oker on 2023/3/28.
//

#import "CollectionHeaderVC.h"
#import <Masonry/Masonry.h>

@interface CVCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *lb;
@end

@implementation CVCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lb = [[UILabel alloc] initWithFrame:CGRectZero];
        _lb.text = @"Test";
        
        [self.contentView addSubview:self.lb];
        [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

@end

@interface CollectionHeaderVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *cv;
@end

@implementation CollectionHeaderVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 50);
        layout.minimumLineSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    [self.cv registerClass:[CVCell class] forCellWithReuseIdentifier:NSStringFromClass(CVCell.class)];
    
    [self.view addSubview:self.cv];
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark ---

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CVCell.class) forIndexPath:indexPath];
    return cell;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第几张 %ld", (long)indexPath.item);
}


@end
