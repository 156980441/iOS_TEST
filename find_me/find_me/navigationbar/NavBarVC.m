//
//  NavBarVC.m
//  find_me
//
//  Created by yunlong on 2022/4/15.
//

#import "NavBarVC.h"

@interface NavBarVC ()

@end

@implementation NavBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
    NSDictionary *textAttributes = @{NSFontAttributeName : [UIFont italicSystemFontOfSize:20],
                                     NSForegroundColorAttributeName : [UIColor redColor]};
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *navBarAppearance = [UINavigationBarAppearance new];
        navBarAppearance.backgroundColor = [UIColor yellowColor];
        navBarAppearance.shadowColor = [UIColor greenColor];
        [navBarAppearance setTitleTextAttributes:textAttributes];
        [navBarAppearance setTitleTextAttributes:textAttributes];
        
        self.navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance;
        self.navigationController.navigationBar.standardAppearance = navBarAppearance;
    } else {
        // Fallback on earlier versions
        UINavigationBar *navBar = self.navigationController.navigationBar;
        navBar.shadowImage = [UIImage new];
        navBar.titleTextAttributes = textAttributes;
    }
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor purpleColor]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Custom NavgationBar";
    
    [self backButton];
    
}

- (void)backButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 44);
    UIImage* image = [UIImage imageNamed:@"icon_timer"];
    [backButton setImage:image forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.adjustsImageWhenHighlighted = YES;
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
