//
//  RootVC.m
//  find_me
//
//  Created by yunlong on 2022/4/15.
//

#import "RootVC.h"

#define TABLEVIEWCELLID @"TABLEVIEWCELLID"

@interface RootVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Find Me";
    
    // Do any additional setup after loading the view.
    self.tv = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    [self.tv registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLEVIEWCELLID];
    [self.view addSubview:self.tv];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"table_view_data_source" ofType:@"plist"];
    NSError *err;
    NSArray *arr = [[NSArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:&err];
    self.dataSource = arr;
    [self.tv reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELLID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}



@end
