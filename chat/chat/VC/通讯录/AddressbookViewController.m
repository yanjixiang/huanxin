//
//  AddressbookViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/22.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "AddressbookViewController.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"

#import "AddViewController.h"
#import "YzViewController.h"
#import "EaseUI.h"
#import "ChatViewController.h"
#import "BlackListViewController.h"
#import "FrientListTableViewCell.h"
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
@interface AddressbookViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,EMContactManagerDelegate,EMChatManagerDelegate>
@property (strong, nonatomic) UITableView *friendTableView;
@property (strong, nonatomic) NSMutableArray *data;/**<所有数据*/

@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/
@end

@implementation AddressbookViewController

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initData];
}
- (void)addFriend {
    AddViewController *detail = [[AddViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"好友列表";
    
    //    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemSearch) target:self action:@selector(searchClick)];
    //        self.navigationItem.rightBarButtonItem = btn;
    //
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
     //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
   
    [self createTableview];
}
- (void)searchClick {
    
}
- (void)createTableview {
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarVC.tabBar.frame.size.height;
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat h = rectOfStatusbar.size.height+self.navigationController.navigationBar.frame.size.height;
    _friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-tabBarHeight-44-h) style:UITableViewStylePlain];
    _friendTableView.backgroundColor = yWhiteColor;
    _friendTableView.delegate = self;
    _friendTableView.dataSource = self;
    [_friendTableView registerClass:[FrientListTableViewCell class] forCellReuseIdentifier:@"cell"];
    _friendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _friendTableView.tableFooterView = [[UIView alloc] init];
    _friendTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.friendTableView];
    self.friendTableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
- (void)initData {
    self.data = [NSMutableArray array];
    _dataSource = [NSMutableArray array];
    
    
    EMError *error = nil;
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",userlist);
        for (NSString *str in userlist) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:str forKey:@"name"];
            [_dataSource addObject:dic];
            
            [self.data addObject:dic];
        }
        _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        NSLog(@"777777777777--------%@",self.data);
        [self.friendTableView reloadData];
    }else {
        NSLog(@"获取好友失败%@",error.errorDescription);
        // 本地数据库获取好友列表
        NSArray *arr = [[EMClient sharedClient].contactManager getContacts];
        for (NSString *str in arr) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:str forKey:@"name"];
            [_dataSource addObject:dic];
            [self.data addObject:dic];
        }
        _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
        
        _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
        
        [self.friendTableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return _indexDataSource.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if (section==0) {
            return 3;
        }else {
            NSArray *value = [_allDataSource objectForKey:_indexDataSource[section-1]];
            return value.count;
        }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        if (section==0) {
            return @"好友管理";
        }else {
            return _indexDataSource[section-1];
        }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _indexDataSource;
}
//联系人列表扩展样例
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                           modelForBuddy:(NSString *)buddy
{
    //用户可以根据自己的用户体系，根据buddy设置用户昵称和头像
    id<IUserModel> model = nil;
    NSLog(@"-------99999999--------%@",buddy);
    model = [[EaseUserModel alloc] initWithBuddy:buddy];
    model.avatarURLPath = @"";//头像网络地址
    model.nickname = @"昵称";//用户昵称
    return model;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     FrientListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
                    cell.img.image = [UIImage imageNamed:@"chaticon1"];
                    cell.nameL.text = @"验证提醒";
                    break;
                case 1:
                    cell.img.image = [UIImage imageNamed:@"chaticon2"];
                    cell.nameL.text = @"添加好友";
                    break;
                case 2:
                    cell.img.image = [UIImage imageNamed:@"chaticon3"];
                    cell.nameL.text = @"黑名单";
                    break;
                default:
                    break;
            }
        }else {
            NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section-1]];
            cell.nameL.text = value[indexPath.row];
            cell.img.image = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
           
        }
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                YzViewController *detail = [[YzViewController alloc] init];
                [self.navigationController pushViewController:detail animated:YES];
            }else if (indexPath.row == 1){
                [self addFriend];
            }else {
                BlackListViewController *detail = [[BlackListViewController alloc] init];
                [self.navigationController pushViewController:detail animated:YES];
            }
            
        }else {
            //        self.hidesBottomBarWhenPushed=YES;
            NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section-1]];
            //        self.block(value[indexPath.row]);
            NSLog(@"--000-----%@",value[indexPath.row]);
            NSString *str;
            for (NSDictionary *dic in self.data) {
                if ([value[indexPath.row] isEqualToString:dic[@"name"]]) {
                    str = dic[@"name"];
                }
            }
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:str conversationType:EMConversationTypeChat];
            [self.navigationController pushViewController:chatController animated:YES];
            //    self.navigationController.hidesBottomBarWhenPushed = NO;
            //        self.hidesBottomBarWhenPushed=NO;
        }
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    NSLog(@"%@同意了您的请求",aUsername);
    [self initData];
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    NSLog(@"%@拒绝了您的请求",aUsername);
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
