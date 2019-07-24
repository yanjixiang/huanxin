//
//  AppDelegate.m
//  chat
//
//  Created by 闫继祥 on 2018/7/30.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
/*
 *引导页
 */
#import "LXGuideViewController.h"
/*
 *判断是否第一次进入
 */
#define App_Run_count_KEY @"runCount"

/*
 *环信头文件
 */
#import <HyphenateLite/HyphenateLite.h>
/*
 *EasyUI头文件
 */
#import "EaseUI.h"
/*
 *通知
 */
#import <UserNotifications/UserNotifications.h>

/*
 *环信key
 */
#define Emchat_key @"ndqidjioq#test"
/*
 *环信中上传的证书名
 */
#define apnsCert_name @"hxtest1"

/*
 *登录页面头文件
 */
#import "LoginViewController.h"
//#import "AppDelegate+EaseMob.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property (strong, nonatomic) RootViewController *mainController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 加载根控制器
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        if (@available(iOS 10.0, *)) {
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        } else {
            // Fallback on earlier versions
        }
    }
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:Emchat_key];
    options.apnsCertName = apnsCert_name;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:Emchat_key apnsCertName:options.apnsCertName                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    
    /**
     注册APNS离线推送  iOS8 注册APNS
     */
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
//    //添加监听在线推送消息
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    if ([NSUserDefaultTools getBooleanValueWithKey:@"haveLogin"]) {
        [self loadRootVC];

    }else {
        LoginViewController *detail = [[LoginViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detail];
        self.window.rootViewController = navi;
    }
    
    return YES;
}
// 加载根控制器
- (void)loadRootVC {
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        [NSUserDefaultTools setBooleanValueWithKey:NO key:@"haveLogin"];
        [NSUserDefaultTools setStringValueWithKey:@"" key:@"token"];
        [NSUserDefaultTools setStringValueWithKey:@"" key:@"user_id"];
        [NSUserDefaultTools setStringValueWithKey:@"" key:@"headUrlImage"];
        [NSUserDefaultTools setStringValueWithKey:@"***" key:@"nickName"];
    }else {
        [NSUserDefaultTools setBooleanValueWithKey:YES key:@"haveLogin"];
        
    }
    
    NSInteger runCount = [[NSUserDefaults standardUserDefaults] integerForKey:App_Run_count_KEY] + 1;
    if (runCount == 1) {
        
        self.window.rootViewController = [[LXGuideViewController alloc] init];
    } else {
        RootViewController *root = [[RootViewController alloc] init];

        self.window.rootViewController = root;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:runCount forKey:App_Run_count_KEY];
}
//收到消息回调
- (void)messagesDidReceive:(NSArray *)aMessages{
    
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        
        if (state == UIApplicationStateBackground) {
            //发送本地推送
            if (NSClassFromString(@"UNUserNotificationCenter")) { // ios 10
                // 设置触发时间
                UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
                UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                content.sound = [UNNotificationSound defaultSound];
                // 提醒，可以根据需要进行弹出，比如显示消息详情，或者是显示“您有一条新消息”
                content.body = @"您有一条新消息";
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
            }else {
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.fireDate = [NSDate date]; //触发通知的时间
                notification.alertBody = @"提醒内容";
                notification.alertAction = @"Open";
                notification.timeZone = [NSTimeZone defaultTimeZone];
                notification.soundName = UILocalNotificationDefaultSoundName;
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            }
        }else {
            
            switch (msgBody.type) {
                case EMMessageBodyTypeText:
                {
                    // 收到的文字消息
                    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                    NSString *txt = textBody.text;
                    NSLog(@"收到的文字是 txt -- %@",txt);
                }
                    break;
                case EMMessageBodyTypeImage:
                {
                    // 得到一个图片消息body
                    EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                    NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                    NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"大图的secret -- %@"    ,body.secretKey);
                    NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                    NSLog(@"大图的下载状态 -- %u",body.downloadStatus);
                    
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                    NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                    NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                    NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                    NSLog(@"小图的下载状态 -- %u",body.thumbnailDownloadStatus);
                }
                    break;
                case EMMessageBodyTypeLocation:
                {
                    EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                    NSLog(@"纬度-- %f",body.latitude);
                    NSLog(@"经度-- %f",body.longitude);
                    NSLog(@"地址-- %@",body.address);
                }
                    break;
                case EMMessageBodyTypeVoice:
                {
                    // 音频sdk会自动下载
                    EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                    NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                    NSLog(@"音频的secret -- %@"        ,body.secretKey);
                    NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"音频文件的下载状态 -- %u"   ,body.downloadStatus);
                    NSLog(@"音频的时间长度 -- %u"      ,body.duration);
                }
                    break;
                case EMMessageBodyTypeVideo:
                {
                    EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                    
                    NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"视频的secret -- %@"        ,body.secretKey);
                    NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"视频文件的下载状态 -- %u"   ,body.downloadStatus);
                    NSLog(@"视频的时间长度 -- %u"      ,body.duration);
                    NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                    NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                    NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                    NSLog(@"缩略图的下载状态 -- %u"      ,body.thumbnailDownloadStatus);
                }
                    break;
                case EMMessageBodyTypeFile:
                {
                    EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                    NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"文件的secret -- %@"        ,body.secretKey);
                    NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"文件文件的下载状态 -- %u"   ,body.downloadStatus);
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
    
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}

//环信断开连接 重连监听
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    NSLog(@"正在重连...");
}
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)userAccountDidLoginFromOtherDevice{
    NSLog(@"当前登录账号在其它设备登录");
    [self isLoginDoing:@"您的账号在别处登录，请前往登录页面在此设备上重新登录"];
}
/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer{
    NSLog(@"当前登录账号已经被从服务器端删除");
    [self isLoginDoing:@"当前登录账号已经被从服务器端删除"];
}
- (void)isLoginDoing:(NSString *)messageStr {
    // 初始化对话框
    [NSUserDefaultTools setBooleanValueWithKey:NO key:@"haveLogin"];
    
    UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aW.rootViewController = [[UIViewController alloc]init];
    aW.windowLevel = UIWindowLevelAlert + 1;
    [aW makeKeyAndVisible];
    LQPopUpView *popUpView = [[LQPopUpView alloc] initWithTitle:@"温馨提示" message:messageStr];
    [popUpView addBtnWithTitle:@"取消" type:LQPopUpBtnStyleCancel handler:^{
        // do something...
        RootViewController *root = [[RootViewController alloc] init];
        root.tabBarController.selectedIndex = 0;
        self.window.rootViewController = root;
    }];
    
    [popUpView addBtnWithTitle:@"确定" type:LQPopUpBtnStyleDefault handler:^{
        // do something...
        LoginViewController *detail = [[LoginViewController alloc] init];
        UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:detail];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
        detail.loginType = @"appdelegateType";
        [aW.rootViewController presentViewController:Nav animated:YES completion:nil];
    }];
    
    [popUpView showInView:aW preferredStyle:0];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}

// 将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


@end
