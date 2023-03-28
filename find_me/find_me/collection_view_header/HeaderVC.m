//
//  HeaderVC.m
//  find_me
//
//  Created by oker on 2023/3/28.
//

#import "HeaderVC.h"
#import <Masonry/Masonry.h>

@interface HeaderVC ()
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UILabel *content;
@end

@implementation HeaderVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _lb = [[UILabel alloc] initWithFrame:CGRectZero];
        _content = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lb.text = @"Title";
    self.lb.textColor = [UIColor whiteColor];
    self.lb.backgroundColor = [UIColor yellowColor];
    
    self.content.text = @"你在使用UITableView时是否用到过tableHeaderView,这个属性让我们设置UITableView的头部视图变得很简单，但是开发中我们有时会用UICollectionView来替代UITableView，然而UICollectionView并没有HeaderView属性，于是很多人并不知道如何设置UICollectionView的头部视图，这里就放上方法。";
    self.content.textColor = [UIColor whiteColor];
    self.content.backgroundColor = [UIColor yellowColor];
    
    
    [self.view addSubview:self.lb];
    [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(16);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(90);
        make.bottom.equalTo(self.view.mas_bottom).offset(-16);
    }];
    
}

@end
