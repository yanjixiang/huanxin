//
//  ConversationViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/22.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "ConversationViewController.h"
/*
 *聊天页面
 */
#import "ChatViewController.h"
@interface ConversationViewController ()<EaseConversationListViewControllerDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EaseConversationListViewControllerDataSource,EaseConversationListViewControllerDelegate>

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = yWhiteColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource=self;
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
    /*
     *添加代理
     */
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}
/*
 *销毁代理
 */
- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
/*
 *页面将要出现刷新聊天列表
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tableViewDidTriggerHeaderRefresh];
}
/*
 *实时刷新消息
 */
- (void)messagesDidReceive:(NSArray *)aMessages {
    [self tableViewDidTriggerHeaderRefresh];
}

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat) {
        NSDictionary *dic = conversation.lastReceivedMessage.ext;
        if(dic[@"nickname"] == nil || dic[@"avatar"] == nil){
            //头像占位图
            model.avatarImage = [UIImage imageNamed:@"logo"];
        }else{
            
            model.title = dic[@"nickname"];
            model.avatarURLPath = dic[@"avatar"];
            //头像占位图
            model.avatarImage = [UIImage imageNamed:@"logo"];
        }
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"subject"])
        {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        NSDictionary *ext = conversation.ext;
        model.title = [ext objectForKey:@"subject"];
        imageName = [[ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        model.avatarImage = [UIImage imageNamed:imageName];
        
        //头像占位图
        model.avatarImage = [UIImage imageNamed:@"logo"];
    }
    return model;
}
/*
 *跳转到聊天页面
 */
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversationModel.conversation.conversationId conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatController animated:YES];
    
}

/*
 *监听好友申请消息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
