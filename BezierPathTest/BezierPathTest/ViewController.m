//
//  ViewController.m
//  BezierPathTest
//
//  Created by fanyl on 2019/4/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "YLBezierCurveView.h"

#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define SCREEN_H  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (strong,nonatomic) YLBezierCurveView *bezierView;
@property (strong,nonatomic) NSMutableArray *x_names;
@property (strong,nonatomic) NSMutableArray *targets;

@end

@implementation ViewController

/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"10/5",@"11/5",@"12/5",@"13/5",@"14/5",@"15/5",@"16/5",@"17/5",@"18/5"]];
    }
    return _x_names;
}
/**
 *  Y轴值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray arrayWithArray:@[@20,@40,@20,@50,@30,@90,@30,@100,@70]];
    }
    return _targets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化
    _bezierView = [[YLBezierCurveView alloc] initWithFrame:CGRectMake(30, 30, SCREEN_W-60, 280)];
    _bezierView.center = self.view.center;
    [self.view addSubview:_bezierView];
    
    //2.折线图
    [self drawLineChart];
    
    //3.柱状图
    //    [self drawBaseChart];
    
    //4.饼状图
    //    [self drawPieChart];
    
}

//画折线图
-(void)drawLineChart{
    
    //直线
        [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Straight];
    
    //曲线
//    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Curve];
}


//画柱状图
-(void)drawBaseChart{
    [_bezierView drawBarChartViewWithX_Value_Names:self.x_names TargetValues:self.targets];
}


//画饼状图
-(void)drawPieChart{
    [_bezierView drawPieChartViewWithX_Value_Names:self.x_names TargetValues:self.targets];
}


@end
