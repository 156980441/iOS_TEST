//
//  ViewController.m
//  3dCollectionView
//
//  Created by yunlong on 2021/6/6.
//

#import "ViewController.h"
#import "3dBannerVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dBannerVC *vc = [[_dBannerVC alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    UIImage *image1 = [UIImage imageNamed:@"coins_0"];
    UIImage *image2 = [UIImage imageNamed:@"coins_0"];
    UIImage *image3 = [UIImage imageNamed:@"coins_0"];
    UIImage *image4 = [UIImage imageNamed:@"coins_0"];
    [vc updateData:@[image1, image2, image3, image4]];
}


@end
