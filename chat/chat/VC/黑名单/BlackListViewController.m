//
//  BlackListViewController.m
//  chat
//
//  Created by 闫继祥 on 2018/8/6.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "BlackListViewController.h"
#import "EaseUI.h"
#import "FrientListTableViewCell.h"
@interface BlackListViewController ()<UITableViewDelegate,UITableViewDataSource,EMContactManagerDelegate,EMChatManagerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *data;

@end

@implementation BlackListViewController
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
    self.navigationItem.title = @"黑名单";
    EMError *error = nil;
    NSArray *blacklist = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",blacklist);
        self.data = blacklist;
    }else {
        NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];
        self.data = blockList;

    }
    [self CreateTable];
}
- (void)CreateTable {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FrientListTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FrientListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = NO;
    cell.nameL.text = self.data[indexPath.row];
    cell.img.image = [UIImage imageNamed:@"zhanweitu"];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"点击了删除");
//    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"移除黑名单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了编辑");
        
        // 将6001移除黑名单
        EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:self.data[indexPath.row]];
        if (!error) {
            NSLog(@"发送成功");
            EMError *error = nil;
            NSArray *blacklist = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
            if (!error) {
                NSLog(@"获取成功 -- %@",blacklist);
                self.data = blacklist;
                [self.tableView reloadData];
            }else {
                NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];
                self.data = blockList;
                [self.tableView reloadData];
            }
        }
    }];
    editAction.backgroundColor = [UIColor redColor];
    return @[editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
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
