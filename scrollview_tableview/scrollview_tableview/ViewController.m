//
//  ViewController.m
//  scrollview_tableview
//
//  Created by fanyl on 2020/11/26.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "SV_TVVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_bottomTV;
    NSArray<NSString *> *_dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bottomTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _bottomTV.delegate = self;
    _bottomTV.dataSource = self;
    [_bottomTV registerClass:UITableViewCell.class forCellReuseIdentifier:@"id"];
    [self.view addSubview:_bottomTV];
    
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    _dataSource = [NSArray arrayWithArray:arr];
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = CGRectGetHeight(self.view.frame);
    
    
    
    _bottomTV.frame = CGRectMake(0, 0, w, h);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    if (indexPath.row == 0) {
        SV_TVVC *vc = [[SV_TVVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
