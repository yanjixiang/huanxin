//
//  ChatViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/17.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "DDChatViewController.h"
#import "ConversationViewController.h"
#import "AddressbookViewController.h"
#import "FSScrollContentView.h"
#import "JohnTopTitleView.h"
#import "ConListViewController.h"
@interface DDChatViewController ()
//@property (nonatomic, strong) FSPageContentView *pageContentView;
//@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation DDChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"叮叮";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    ConListViewController *vc1 = [[ConListViewController alloc]init];
    AddressbookViewController *vc2 = [[AddressbookViewController alloc]init];
    vc1.title = @"会话记录";
    vc2.title = @"通讯录";
  
    NSArray *controllers=@[vc1,vc2];
    NSArray *titleArray = @[@"会话记录", @"通讯录"];
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    
    _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    _titleView.canScroll = NO;
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor redColor];
    _titleView.selectedTextColor = [UIColor redColor];
    self.titleView.titles = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:controllers];
    [self.view addSubview:self.titleView];
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
