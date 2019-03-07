//
//  ViewController.m
//  UIScrollViewTest
//
//  Created by fanyl on 2019/3/1.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.scrollView];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"veer.jpg"];
    CGFloat imgW = self.imageView.image.size.width; // 图片的宽度
    CGFloat imgH = self.imageView.image.size.height; // 图片的高度
    self.imageView.frame = CGRectMake(0, 0, imgW, imgH);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit; // 防止图片在变换的过程中失真
    [self.scrollView addSubview:self.imageView];
    
    // 代理
    self.scrollView.delegate = self;
    // 颜色
    self.scrollView.backgroundColor = [UIColor blueColor];
    // UIScrollView的可视范围
    self.scrollView.frame = CGRectMake(50, 50, 200, 300);
    // 设置UIScrollView的滚动范围（内容大小）
    self.scrollView.contentSize = self.imageView.image.size;
    // 隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    // 设置滚动条的样式
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    // 添加四条边距(相当于相框部分!相框，很好理解)
    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // 弹簧效果(所谓弹簧效果就是不论图片被拽托到滚动图内那儿松开后都会返回原来的位置上)
    self.scrollView.bounces = NO;
    // 滚动效果(图片太大时,能否拖拽着移动查看其他部分)
    self.scrollView.scrollEnabled = YES;
    // 设置滚动视图的放大和缩小的系数
    self.scrollView.minimumZoomScale = 0.8;
    self.scrollView.maximumZoomScale = 2.0;
    // 按页滚动
    self.scrollView.pagingEnabled = NO;
    // 设置内容的偏移量，contentOffset 参照 bound.origin 的坐标系，y 向上为正，x 向右为正
    self.scrollView.contentOffset = CGPointMake(0, 0);
    // 是否可以滚动到内容的顶部，没理解！！
    self.scrollView.scrollsToTop = YES;
    
}

#pragma mark - UIScrollViewDelegate

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"开始拖动");
}

// 只要发生滚动，就会调用该方法 any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"滚动 contentoffset.y = %f", scrollView.contentOffset.y);
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 取消UIScrollView的惯性滑动
    CGFloat speed = fabs(velocity.y); // 滚动速度的绝对值，也可以根据 velocity.y 的正负判读滚动方向 假如为0 说明手动拖动停止 没有惯性滑动
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat maxSpeed = 2.7; // 超过这个最大速度要做的操作
    if(velocity.y < 0) { // 手向下滑动
        if (speed > maxSpeed && offsetY > 0) { // 从顶部往下滑
            [self performSelectorOnMainThread:@selector(stopOnTop:) withObject:scrollView waitUntilDone:NO];//一定要在主线程立即执行 和 runLoop有关
            
        }
    }
    else { // 手向上滑动
        
    }
    
    NSLog(@"==== 将要结束拖动 speed %f, velocity.y %f, contentOffset.y %f", speed, velocity.y, scrollView.contentOffset.y);
}

- (void)stopOnTop:(UIScrollView *)scrollView {// 在顶部停止滚动
    
    [scrollView setContentOffset:CGPointZero animated:YES];
    
}



// 只要zoomScale发生变化，就会调用该方法 any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"缩放");
}


// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    NSLog(@"拖动结束");
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"将要开始减速");
}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"减速结束"); // 停止滚动
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"滚动动画结束");
}

// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    NSLog(@"将要开始缩放");
}

// return a view that will be scaled. if delegate returns nil, nothing happens
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"view:%@,scale:%f", view,scale); // 输出放缩后的视图信息和放缩系数
}

// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    // scrollToTop = YES,才会调用该方法
    // 返回YES，可以滚动到顶部；NO 不可以
    return YES;
}

// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"滚动到顶部");
}


@end
