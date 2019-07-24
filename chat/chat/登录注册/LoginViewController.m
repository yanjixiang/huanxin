//
//  LoginViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/17.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "LoginViewController.h"
#import "EaseUI.h"
#import "ResignViewController.h"
#import "ForgrtPWViewController.h"
#import "RootViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *user;
    NSString *pw;
    UITextField *userTF;
    UITextField *userPW;
}


@end

@implementation LoginViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"密码登录";
    
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat h = rectOfStatusbar.size.height+self.navigationController.navigationBar.frame.size.height;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, h+40, 20, 20)];
    imgView.image = [UIImage imageNamed:@"手机login"];
    [self.view addSubview:imgView];
    
    userTF = [[UITextField alloc] initWithFrame:CGRectMake(60, h+30, self.view.frame.size.width-80, 40)];
    
    userTF.delegate = self;
    
    userTF.placeholder = @"请输入手机号";
    userTF.keyboardType = UIKeyboardTypePhonePad;
    
    [self.view addSubview:userTF];
    [userTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    userTF.text = [NSUserDefaultTools getStringValueWithKey:@"user_id"];
    user = [NSUserDefaultTools getStringValueWithKey:@"user_id"];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(20,userTF.height+userTF.y+1, SCREEN_WIDTH-40, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line1];
    
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.height+line1.y+40, 20, 20)];
    imgView1.image = [UIImage imageNamed:@"验证码login"];
    [self.view addSubview:imgView1];
    
    userPW = [[UITextField alloc] initWithFrame:CGRectMake(60, line1.height+line1.y+30, self.view.frame.size.width-80, 40)];
    userPW.delegate = self;
    userPW.placeholder = @"请输入密码";
    [self.view addSubview:userPW];
    [userPW addTarget:self action:@selector(textFieldDidChange1:) forControlEvents:UIControlEventEditingChanged];
    userPW.secureTextEntry = YES;
    
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(20,userPW.height+userPW.y+1, SCREEN_WIDTH-40, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line2];
    
    
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogin.frame = CGRectMake(20, line2.height+line2.y+40, SCREEN_WIDTH-40, 50);
    buttonLogin.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonLogin];
    [buttonLogin addTarget:self action:@selector(buttonLogin) forControlEvents:UIControlEventTouchUpInside];
    [buttonLogin setTitle:@"登录" forState:(UIControlStateNormal)];
    buttonLogin.layer.cornerRadius = 25;
    buttonLogin.clipsToBounds = YES;
    [buttonLogin setTitleColor:yWhiteColor forState:(UIControlStateNormal)];
    buttonLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    //验证码登录
    UIButton *buttonLoginPw = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLoginPw.frame = CGRectMake(20, buttonLogin.height+buttonLogin.y+20, 100, 30);
    buttonLoginPw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonLoginPw];
    [buttonLoginPw addTarget:self action:@selector(buttonLoginYZMClick) forControlEvents:UIControlEventTouchUpInside];
    [buttonLoginPw setTitle:@"注册" forState:(UIControlStateNormal)];
    buttonLoginPw.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonLoginPw setTitleColor:yLightGrayColor forState:(UIControlStateNormal)];
    
    
}
//注册
- (void)buttonLoginYZMClick {
    ResignViewController *detail = [[ResignViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


/*
 *登录按钮点击方法实现
 */
- (void)buttonLogin {
    [self.view endEditing:YES];
    NSLog(@"%@-------%@",user,pw);
    //    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    //    if (!isAutoLogin) {
    if (user.length == 0) {
        [DialogTool showDlg:@"请输入账号"];
        return;
    }
    if (pw.length == 0) {
        [DialogTool showDlg:@"请输入密码"];
        
        return;
    }
    EMError *error = [[EMClient sharedClient] loginWithUsername:user password:pw];
    if (!error) {
        NSLog(@"登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        [NSUserDefaultTools setBooleanValueWithKey:YES key:@"haveLogin"];
        //        RootViewController *root = [[RootViewController alloc] init];
        //        [self presentViewController:root animated:YES completion:nil];
        [NSUserDefaultTools setBooleanValueWithKey:YES key:@"haveLogin"];
        [NSUserDefaultTools setStringValueWithKey:@"" key:@"token"];
        [NSUserDefaultTools setStringValueWithKey:user key:@"user_id"];
        [NSUserDefaultTools setStringValueWithKey:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2153937626,1074119156&fm=27&gp=0.jpg" key:@"headUrlImage"];
        [NSUserDefaultTools setStringValueWithKey:@"小刚" key:@"nickName"];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        RootViewController *detail = [[RootViewController alloc] init];
        window.rootViewController = detail;
    }else {
        NSLog(@"error-----%@",error.errorDescription);
    }
}
/*
 *监测textfiled输入框内容改变
 */
-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    user = theTextField.text;
}
-(void)textFieldDidChange1 :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    pw = theTextField.text;
    
}

/*
 *键盘消失
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
