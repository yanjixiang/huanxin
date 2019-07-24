//
//  ConListViewController.h
//  HuanXinDemo
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 ZYJZODOIT. All rights reserved.
//

#import "EaseConversationListViewController.h"

@interface ConListViewController : EaseConversationListViewController
@property (strong, nonatomic) NSMutableArray *conversationsArray;

- (void)refresh;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;
@end
