//
//  YzViewController.m
//  chat
//
//  Created by 闫继祥 on 2018/8/6.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "YzViewController.h"
#import "EaseUI.h"
#import "YzTableViewCell.h"
#import "LQPopUpView.h"
@interface YzViewController ()<UITableViewDelegate,UITableViewDataSource,EMContactManagerDelegate,EMChatManagerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *name;

@end

@implementation YzViewController
//隐藏底部
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"好友验证";
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [self CreateTable];
}
- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
- (void)CreateTable {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[YzTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YzTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = NO;
    [cell.agree addTarget:self action:@selector(agreeClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.agree.tag = indexPath.row;
    
    [cell.disAgree addTarget:self action:@selector(disAgreeClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.agree.tag = indexPath.row;
    cell.selectionStyle = NO;
    return cell;
}
//监听好友申请消息
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    //    self.str = aUsername;
    //    self.str1 = aMessage;
    NSLog(@"00-----%@",aUsername);
    NSLog(@"%@",aMessage);

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    YzTableViewCell *cell = (YzTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.name.text = [NSString stringWithFormat:@"来自%@的好友申请",aUsername];
        cell.detail.text = aMessage;
        cell.image.image = [UIImage imageNamed:@"zhanweitu"];
        self.name = aUsername;
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:aUsername,@"username",aMessage,@"message", nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:dic forKey:@"dic"];
    
    [userDefaults synchronize];
    
    //    NSString *title = [NSString stringWithFormat:@"来自%@的好友申请",username];
    //    UIAlertController *alterController = [YCCommonCtrl commonAlterControllerWithTitle:title message:message];
    //    [self.window.rootViewController presentViewController:alterController animated:YES completion:nil];
    NSLog(@"777------%@",aUsername);
    NSLog(@"%@",aMessage);
//    [self.tableView reloadData];
}

- (void)agreeClick:(UIButton *)btn {
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.name];
    if (!error) {
        NSLog(@"发送同意成功");
        LQPopUpView *popUpView = [[LQPopUpView alloc] initWithTitle:@"提示" message:@"发送同意成功"];
        
        [popUpView addBtnWithTitle:@"我知道了" type:LQPopUpBtnStyleDefault handler:^{
            // do something...
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [popUpView showInView:self.view preferredStyle:0];
        
    }
}
- (void)disAgreeClick:(UIButton *)btn {
    EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.name];
    if (!error) {
        NSLog(@"发送拒绝成功");
        LQPopUpView *popUpView = [[LQPopUpView alloc] initWithTitle:@"提示" message:@"发送拒绝成功"];
        
        [popUpView addBtnWithTitle:@"我知道了" type:LQPopUpBtnStyleDefault handler:^{
            // do something...
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [popUpView showInView:self.view preferredStyle:0];
    }
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    NSLog(@"%@同意了您的请求",aUsername);
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    NSLog(@"%@拒绝了您的请求",aUsername);

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
