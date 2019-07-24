//
//  ChatViewController.h
//  chat
//
//  Created by 闫继祥 on 2018/8/7.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUI.h"
@interface ChatViewController : EaseMessageViewController
@property(nonatomic, copy)NSString *idStr;
@property(nonatomic, copy)NSString *pushtype;

@end
