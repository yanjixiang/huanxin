//
//  AddressbookViewController.h
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/22.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUsersListViewController.h"
typedef void(^SelectedItem)(NSString *item);

NS_ASSUME_NONNULL_BEGIN

@interface AddressbookViewController : UIViewController
@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;
@end

NS_ASSUME_NONNULL_END
