//
//  TestRootVC.m
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import "TestRootVC.h"
#import "YL2LabelsViewTVCell.h"
#import "YL2LabelsView.h"

@interface TestRootVC () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TestRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"layoutSubViews"];
    [self setupUI];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    self.title = @"Test";
}

- (void)layoutUI {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YL2LabelsViewTVCell *cell = [tableView dequeueReusableCellWithIdentifier:g_2LabelsViewTVCellId forIndexPath:indexPath];
    cell.innerView.firstLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16] ,
                                 NSForegroundColorAttributeName:YLColor_Disable,
                                 NSParagraphStyleAttributeName:paragraph};
    
    return [[NSAttributedString alloc] initWithString:@"暂无记录" attributes:attributes];
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (UITableView*)tableView {
    if (!_tableView) {
        UITableView* temp = [UIFactory getTableView:UITableViewStylePlain cellClass:YL2LabelsViewTVCell.class identifier:g_2LabelsViewTVCellId];
        temp.dataSource = self;
        temp.delegate = self;
        temp.emptyDataSetSource = self;
        temp.emptyDataSetDelegate = self;
        
        temp.estimatedSectionHeaderHeight = 0;
        temp.estimatedSectionFooterHeight = 0; // 关闭自适应高
        
        _tableView = temp;
    }
    return _tableView;
}

@end
