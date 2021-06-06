//
//  3dBannerVC.m
//  3dCollectionView
//
//  Created by yunlong on 2021/6/6.
//

#import "3dBannerVC.h"
#import "3dLayout.h"
#import "BannerCVCell.h"

#define kSectionCount 1

@interface _dBannerVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource>
{
    UICollectionView *_cv;
    NSArray *_ds;
}
@end

@interface _dBannerVC ()

@end

@implementation _dBannerVC

- (void)updateData:(NSArray *)data {
    _ds = data;
    [_cv reloadData];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dLayout *layout = [[_dLayout alloc] init];
        layout.itemSize = CGSizeMake(327, 532);
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 17, 0, 17);
        
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_cv registerClass:[BannerCVCell class] forCellWithReuseIdentifier:@"BannerCVCellID"];
        _cv.delegate = self;
        _cv.dataSource = self;
        _cv.backgroundColor = [UIColor lightGrayColor];
        _cv.showsHorizontalScrollIndicator = NO;
        _cv.showsVerticalScrollIndicator = NO;

//        _cv.pagingEnabled = YES; // 不过这种设置只适用于内部cell之间的间距与边距一致的情况
                //开始时让CollectionView滚动到一个中间位置
                //计算frame，确保Item居中
//                [_cv setContentOffset:CGPointMake((kItemWidth+kSpace)*kSectionCount/2-kItemSpace, 0)];
        [_cv setContentOffset:CGPointMake(0, 0)];
        
    }
    return self;
}

- (void)p_close:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:_cv];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _cv.frame = self.view.bounds;
}

#pragma mark ---

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // 这里尽可能给个大值，这样在视觉上会有轮播的效果，但其实我们已经换组
    // collection自带重用机制，所以并不会造成性能上额外损耗
    return kSectionCount; // 这里居然可以制造无限循环？
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCVCellID" forIndexPath:indexPath];
    [cell updateUIWithData:_ds[indexPath.row]];
    return cell;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ds.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第几张 %ld", (long)indexPath.item);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
