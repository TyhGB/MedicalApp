//
//  MainTabBarViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/1.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "IndexViewController.h"
#import "NewsViewController.h"
#import "ClinicViewController.h"
#import "MeViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    IndexViewController * indexVC = [[IndexViewController alloc]init];
    indexVC.title = @"橙邻橙里测试机构";
    indexVC.navigationItem.backBarButtonItem.title =@"1";
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:indexVC];
    nav1.tabBarItem.title = @"首页";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"index"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"indexSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [nav1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} forState:UIControlStateSelected];
    
    
    
    NewsViewController * newsVC = [[NewsViewController alloc]init];
    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:newsVC];
    newsVC.title=@"诊所消息";
    nav2.tabBarItem.title = @"消息";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"newsSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [nav2.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} forState:UIControlStateSelected];
    
    ClinicViewController * clinicVC = [[ClinicViewController alloc]init];
    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:clinicVC];
    clinicVC.title = @"诊所服务";
    nav3.tabBarItem.title = @"诊所咨询";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"clinic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"clinicSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [nav3.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} forState:UIControlStateSelected];
    
    MeViewController * meVC = [[MeViewController alloc]init];
    UINavigationController * nav4 = [[UINavigationController alloc]initWithRootViewController:meVC];
    meVC.title = @"我";
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"meSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [nav4.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} forState:UIControlStateSelected];
    self.viewControllers = @[nav1,nav2,nav3,nav4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
