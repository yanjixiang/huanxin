//
//  DialogTool.m

#import "MBProgressHUD.h"
#import "DialogTool.h"

@implementation DialogTool

+(void)showDlg:(UIView *)view withLabel:(NSString *)label afterDelay:(NSTimeInterval)afterDelay
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelFont = [UIFont systemFontOfSize:15];
        hud.labelText = label;
        hud.margin = 5.0f;
        hud.layer.cornerRadius = 1.0f;
        hud.yOffset = 150.f;
        [hud show:YES];
        [hud hide:YES afterDelay:afterDelay];
    });
}
+(void)showDlghud:(NSString *)label
{
    [self showDlg:[[UIApplication sharedApplication].delegate window] withLabel:label afterDelay:2];
}
+(void)showDlg:(NSString *)label
{
    [self showDlg:[[UIApplication sharedApplication].delegate window] withLabel:label afterDelay:1];
}
+(void)showDlg:(UIView *)view withLabel:(NSString *)label
{
    [self showDlg:view withLabel:label afterDelay:1];
}
@end
