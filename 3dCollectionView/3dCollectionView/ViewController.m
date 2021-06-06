//
//  ViewController.m
//  3dCollectionView
//
//  Created by yunlong on 2021/6/6.
//

#import "ViewController.h"
#import "3dBannerVC.h"
#import "PageLayout.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray<NSString *> *_ds;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ds = @[@"3d banner", @"3d page banner"];
    
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:tv];
    tv.delegate = self;
    tv.dataSource = self;
    [tv reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    if (cell) {
        cell.textLabel.text = _ds[indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ds.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image1 = [UIImage imageNamed:@"coins_0"];
    UIImage *image2 = [UIImage imageNamed:@"coins_0"];
    UIImage *image3 = [UIImage imageNamed:@"coins_0"];
    UIImage *image4 = [UIImage imageNamed:@"coins_0"];
    if (indexPath.row == 0) {
        _dBannerVC *vc = [[_dBannerVC alloc] initWithLayout:nil];
        [vc updateData:@[image1, image2, image3, image4]];
        [self.navigationController pushViewController:vc animated:NO];
    }
    else if (indexPath.row == 1) {
        PageLayout *layout = [[PageLayout alloc] init];
        layout.itemSize = CGSizeMake(327, 532);
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 17, 0, 17);
        _dBannerVC *vc = [[_dBannerVC alloc] initWithLayout:layout];
        [vc updateData:@[image1, image2, image3, image4]];
        [self.navigationController pushViewController:vc animated:NO];
    }
}


@end
