//
//  SearchTableViewVC.m
//  find_me
//
//  Created by yunlong on 2022/4/25.
//

#import "SearchTableViewVC.h"
#import "CountryTVCell.h"

@interface SearchTableViewVC ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchField;
@end

@implementation SearchTableViewVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _searchField = [[UITextField alloc] initWithFrame:CGRectZero];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)configUI {
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:CountryTVCell.class forCellReuseIdentifier:@"CountryTVCell"];
    
    self.searchField.tintColor = [UIColor yellowColor];
    self.searchField.textColor = [UIColor blackColor];
    self.searchField.font = [UIFont systemFontOfSize:16];
    self.searchField.delegate = self;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchField addTarget:self
                         action:@selector(textDidChange:)
               forControlEvents:UIControlEventEditingChanged];
}

@end
