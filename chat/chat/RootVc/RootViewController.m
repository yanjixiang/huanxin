//
//  ViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/17.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "RootViewController.h"
#import "DDChatViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "EaseUI.h"

@interface RootViewController ()<UITabBarDelegate,UITabBarControllerDelegate>


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = yWhiteColor;
    //textfield光标颜色
    [[UITextField appearance] setTintColor:[UIColor lightGrayColor]];

    //底部tabbar背景色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
  
    
    DDChatViewController *chat = [[DDChatViewController alloc]init];
    UINavigationController *chatNavi = [[UINavigationController alloc]initWithRootViewController:chat];
    chatNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"叮叮" image:[UIImage imageNamed:@"foot4"] tag:4000];
    chatNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"foot4_curr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MineViewController *mine = [[MineViewController alloc]init];
    UINavigationController *mineNavi = [[UINavigationController alloc]initWithRootViewController:mine];
    mineNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"foot5"] tag:5000];
    mineNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"foot5_curr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[chatNavi,mineNavi];
    //修改选中状态tabbar的字体颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:yRedColor} forState:UIControlStateSelected];
    //Normal
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:yLightGrayColor} forState:UIControlStateNormal];
    
    
     
}
/*
 *tabbar的点击方法
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"--tabbaritem.title--%@",viewController.tabBarItem.title);
    //    NSString *str = [[NSUserDefaults standardUserDefaults]valueForKey:@"logi"];
    
    if ([viewController.tabBarItem.title isEqualToString:@"叮叮"]) {
        NSLog(@"333333");
        if (![NSUserDefaultTools getBooleanValueWithKey:@"haveLogin"]){
           BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                LoginViewController *login = [[LoginViewController alloc] init];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
                [self presentViewController:navi animated:YES completion:nil];
                //                    LoginViewController *root = [[LoginViewController alloc] init];
                //                    window.rootViewController = root;
            }
            return NO;
        }
        
    }
    return YES;
    
}



@end
