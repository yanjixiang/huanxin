//
//  DialogTool.h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DialogTool : NSObject
/**
 *  显示hud 默认延迟一秒
 *
 *  @param label 提示语
 */
+(void)showDlg:(NSString *)label;
/**
 *  显示hud 默认延迟一秒
 *
 *  @param view  父view
 *  @param label 提示语
 */
+(void)showDlg:(UIView *)view withLabel:(NSString *)label;
/**
 *  显示hud
 *
 *  @param view       父view
 *  @param label      提示语
 *  @param afterDelay 显示多少时间
 */
+(void)showDlg:(UIView *)view withLabel:(NSString *)label afterDelay:(NSTimeInterval)afterDelay;
/**
 *  改变显示时间
 *
 *  @param label 提示语
 */
+(void)showDlghud:(NSString *)label;


@end
