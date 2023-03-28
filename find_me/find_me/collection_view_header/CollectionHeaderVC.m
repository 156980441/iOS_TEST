//
//  CollectionHeaderVC.m
//  find_me
//
//  Created by oker on 2023/3/28.
//

#import "CollectionHeaderVC.h"
#import "HeaderVC.h"
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
        _lb.textColor = [UIColor whiteColor];
        _lb.backgroundColor = [UIColor yellowColor];
        
        [self.contentView addSubview:self.lb];
        [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(3, 3, 3, 3));
        }];
        
        self.contentView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end

@interface CollectionHeaderVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *cv;
@property (nonatomic, strong) HeaderVC *headVC;
@end

@implementation CollectionHeaderVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 50);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 18;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _headVC = [[HeaderVC alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.cv.backgroundColor = [UIColor orangeColor];
    
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    [self.cv registerClass:[CVCell class] forCellWithReuseIdentifier:NSStringFromClass(CVCell.class)];
    
    [self.view addSubview:self.cv];
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    CGFloat h = self.headVC.VCHeight;
    
    self.cv.contentInset = UIEdgeInsetsMake(h, 0, 0, 0);
    
    [self addChildViewController:self.headVC];
    [self.cv addSubview:self.headVC.view];
    
    
    NSLog(@"Header viewDidLoad %f", h);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.cv layoutIfNeeded];
    CGFloat h = self.headVC.VCHeight;
    self.headVC.view.frame = CGRectMake(0, -h, CGRectGetWidth(self.cv.frame), h);
    NSLog(@"Header viewWillLayoutSubviews %f", h);
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
