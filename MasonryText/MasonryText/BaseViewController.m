//
//  BaseViewController.m
//  MasonryText
//
//  Created by fanyl on 2019/5/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "BaseViewController.h"

#import "Masonry.h"

// https://www.jianshu.com/p/b5fe6c20f162

/*
 一个红色父View, 上左右分别距屏幕50(内边距),
 红色View里面上面有一个绿色字View, 这个绿色View距上100, 宽度200, 高度200,   在红色View竖直中线
 红色View里面还有个黄色Label, label顶部距绿色View底部20, 宽度和绿色View一样, 底部和红色View底部距离20
 */
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* superView = self.view;
    
    
    
    
    /*
     它内部的控件布局决定的, 它内部有两个子控件, 绿色View的位置可以确定下来, 但是label的要有多少文字, 不知道, 也就不知道label有多高, label又要里红色VIew底部20 , 所以暂时红色View的高度, 或者说底部位置还不能定下来
     */
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(64 + 50);
        make.left.equalTo(superView).offset(50);
        make.right.equalTo(superView).offset(-50);
    }];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    [redView addSubview:greenView];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(redView);
    }];
    
    /*
     注意, 其实至此, 对于label来说, 这些约束就足够了, 看一下, 和之前的 View 相比, 貌似还缺了写什么, 也不满足通常来说的4条(其实frame不就是4条约束嘛, x代表距左, y代表距上, width代表宽, height代表高, 这样一个view就可以确定位置了), 观察这个View的目前布局, 目前缺少了高度, 或者说底部约束, 这是因为在宽度确定的情况下, label会自动撑开自己所需的高度.
     */
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    label.numberOfLines = 0;
    label.text = @"三扥黄森老将老将赛疯狂森囧带肯老将赛疯狂森囧带肯赛疯狂森囧带肯交两三";
    [redView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(20);
        make.width.mas_equalTo(greenView);
        make.centerX.equalTo(greenView);
        make.bottom.equalTo(redView).offset(-20);
    }];
    /*
     一定要加上make.bottom.equalTo(redView).offset(-20);, 让黄色label的底部对红色View的底部做一个约束, 把红色View撑开 , 才构成了整个完整的约束. 也补上了redView最开始缺的一条
     */
    
}

@end
