//
//  MineViewController.m
//  chat
//
//  Created by 闫继祥 on 2019/7/23.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "MineViewController.h"
#import <HyphenateLite/HyphenateLite.h>
#import "LoginViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"退出" forState:(UIControlStateNormal)];
    [button setTitleColor:yWhiteColor forState:(UIControlStateNormal)];
    button.frame = CGRectMake(15, 200, SCREEN_WIDTH-30, 40);
    button.backgroundColor = [UIColor colorWithHexString:@"#1296db"];
    [self.view addSubview:button];
    button.layer.cornerRadius = 15;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}
//退出登录
- (void)buttonClick {
    BOOL result = [NSUserDefaultTools getBooleanValueWithKey:@"haveLogin"];
    if(!result){
        [DialogTool showDlg:@"您没有登录,不需要退出"];
    }else{
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"退出成功");
            [NSUserDefaultTools setBooleanValueWithKey:NO key:@"haveLogin"];
            [NSUserDefaultTools setStringValueWithKey:@"" key:@"token"];
            LoginViewController *detail =[[LoginViewController alloc] init];
            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:detail];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = Nav;
        }
        
    }
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
