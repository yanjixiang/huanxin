//
//  ChatViewController.m
//  chat
//
//  Created by 闫继祥 on 2018/8/7.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "ChatViewController.h"
#import "LQPopUpView.h"
@interface ChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation ChatViewController
//隐藏底部
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉多余不用的加号工具栏里面的按钮
    [self.chatBarMoreView removeItematIndex:3];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.delegate = self;
    self.dataSource = self;
    self.chatBarMoreView.delegate = self;
//    self.navigationItem.title = self.conversation.conversationId;
//    if (self.pushtype.length==0) {
        UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"头像zhanweitu"] style:(UIBarButtonItemStylePlain) target:self action:@selector(personLibCLICK)];
        self.navigationItem.rightBarButtonItem = btnRight;
//    }
    //去掉多余不用的加号工具栏里面的按钮
    [self.chatBarMoreView removeItematIndex:4];
    
}
- (void) personLibCLICK {
    NSLog(@"别点我");
}
//加入黑名单
- (void)addBlackFriend {
    //    将6001加入黑名单
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:self.conversation.conversationId relationshipBoth:YES];
    if (!error) {
        NSLog(@"发送成功");
        LQPopUpView *popUpView = [[LQPopUpView alloc] initWithTitle:@"提示" message:@"添加成功"];
        
        [popUpView addBtnWithTitle:@"取消" type:LQPopUpBtnStyleCancel handler:^{
            // do something...
        }];
        
        [popUpView addBtnWithTitle:@"确定" type:LQPopUpBtnStyleDefault handler:^{
            // do something...
        }];
        
        [popUpView showInView:self.view preferredStyle:0];
        
    }
}
//用户点击头像回调
- (void) messageViewController:(EaseMessageViewController *)viewController didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    if (!messageModel.isSender) {
        NSLog(@"----%@",self.conversation.conversationId);
    }
}
/*
 *工具栏点击方法
 */
- (void)moreView:(EaseChatBarMoreView *)moreView didItemInMoreViewAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}


- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 @method
 @brief 触发长按手势
 @discussion 获取触发长按手势的回调，默认是NO
 @param viewController 当前消息视图
 @param indexPath 长按消息对应的indexPath
 @result
 */
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath {
    //样例给出的逻辑是长按cell之后显示menu视图
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
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
