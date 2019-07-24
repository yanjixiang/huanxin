//
//  ResignViewController.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/1/17.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "ResignViewController.h"
#import "EaseUI.h"
#import "GCDCountDown.h"
#import "RootViewController.h"
@interface ResignViewController ()<UITextFieldDelegate,GCDCountDownDelegate>{
    NSString *user;
    NSString *pw;
    NSString *pwAgain;
    NSString *yzmStr;

    UITextField *userTF;
    UITextField *yzmTF;
    UITextField *userPW;
    UITextField *userPWAgain;
    UIButton *buttonGetYZM;
}
@property (nonatomic,strong) GCDCountDown *countDowntor;

@end

@implementation ResignViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账号注册";
    self.view.backgroundColor = yWhiteColor;
   
    
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
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(20,userTF.height+userTF.y+1, SCREEN_WIDTH-40, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line1];
//
//
//    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.height+line1.y+25, 20, 20)];
//    imgView1.image = [UIImage imageNamed:@"验证码login"];
//    [self.view addSubview:imgView1];
//
//    yzmTF = [[UITextField alloc] initWithFrame:CGRectMake(60, line1.height+line1.y+15, self.view.frame.size.width-80, 40)];
//    yzmTF.delegate = self;
//    yzmTF.placeholder = @"请输入验证码";
//    [self.view addSubview:yzmTF];
//    [yzmTF addTarget:self action:@selector(textFieldDidChange1:) forControlEvents:UIControlEventEditingChanged];
//    yzmTF.keyboardType = UIKeyboardTypeNumberPad;
//
//    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(20,yzmTF.height+yzmTF.y+1, SCREEN_WIDTH-40, 1)];
//    line2.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
//    [self.view addSubview:line2];
//
//
//    buttonGetYZM = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonGetYZM.frame = CGRectMake(yzmTF.width-100, 5, 100, 30);
//    buttonGetYZM.backgroundColor = [UIColor redColor];
//    [yzmTF addSubview:buttonGetYZM];
//    buttonGetYZM.clipsToBounds = YES;
//    buttonGetYZM.layer.cornerRadius = 15;
//    [buttonGetYZM addTarget:self action:@selector(yzmClick) forControlEvents:UIControlEventTouchUpInside];
//    [buttonGetYZM setTitle:@"发送验证码" forState:(UIControlStateNormal)];
//    buttonGetYZM.titleLabel.font = [UIFont systemFontOfSize:14];
//    [buttonGetYZM setTitleColor:yWhiteColor forState:(UIControlStateNormal)];
//    [buttonGetYZM addTarget:self action:@selector(yzmClick) forControlEvents:UIControlEventTouchUpInside];
//    self.countDowntor = [[GCDCountDown alloc]initWithTime:60];
//    self.countDowntor.delegate = self;
//    buttonGetYZM.enabled = YES;
//    buttonGetYZM.hidden = YES;
//
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.height+line1.y+25, 20, 20)];
    imgView2.image = [UIImage imageNamed:@"确认密码"];
    [self.view addSubview:imgView2];
    
    userPW = [[UITextField alloc] initWithFrame:CGRectMake(60, line1.height+line1.y+15, self.view.frame.size.width-80, 40)];
    userPW.delegate = self;
    userPW.placeholder = @"请输入密码";
    [self.view addSubview:userPW];
    [userPW addTarget:self action:@selector(textFieldDidChange2:) forControlEvents:UIControlEventEditingChanged];
//    userPW.keyboardType = UIKeyboardTypeNumberPad;
    userPW.secureTextEntry = YES;

    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(20,userPW.height+userPW.y+1, SCREEN_WIDTH-40, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line3];
    
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, line3.height+line3.y+25, 20, 20)];
    imgView3.image = [UIImage imageNamed:@"确认密码"];
    [self.view addSubview:imgView3];
    
    userPWAgain = [[UITextField alloc] initWithFrame:CGRectMake(60, line3.height+line3.y+15, self.view.frame.size.width-80, 40)];
    userPWAgain.delegate = self;
    userPWAgain.placeholder = @"请再次输入密码";
    [self.view addSubview:userPWAgain];
    [userPWAgain addTarget:self action:@selector(textFieldDidChange3:) forControlEvents:UIControlEventEditingChanged];
    userPWAgain.secureTextEntry = YES;

//    userPWAgain.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(20,userPWAgain.height+userPWAgain.y+1, SCREEN_WIDTH-40, 1)];
    line4.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line4];
    
    UIButton *buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLogin.frame = CGRectMake(20, line4.height+line4.y+40, SCREEN_WIDTH-40, 50);
    buttonLogin.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonLogin];
    [buttonLogin addTarget:self action:@selector(buttonResign) forControlEvents:UIControlEventTouchUpInside];
    [buttonLogin setTitle:@"注册" forState:(UIControlStateNormal)];
    buttonLogin.layer.cornerRadius = 25;
    buttonLogin.clipsToBounds = YES;
    [buttonLogin setTitleColor:yWhiteColor forState:(UIControlStateNormal)];
    buttonLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //隐私协议
    UIButton *buttonLoginPw = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLoginPw.frame = CGRectMake(SCREEN_WIDTH-100, buttonLogin.height+buttonLogin.y+20, 80, 30);
    buttonLoginPw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonLoginPw];
    [buttonLoginPw addTarget:self action:@selector(buttonLoginPwClick) forControlEvents:UIControlEventTouchUpInside];
    [buttonLoginPw setTitle:@"隐私协议" forState:(UIControlStateNormal)];
    buttonLoginPw.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonLoginPw setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:(UIControlStateNormal)];
}
//隐私协议
- (void)buttonLoginPwClick {
//    PWLoginViewController *detail = [[PWLoginViewController alloc] init];
//
//    [self.navigationController pushViewController:detail animated:YES];
}

//获取验证码
//发生网络请求 --> 获取验证码
- (void)yzmClick {
    [self.view endEditing:YES];
    //    NSLog(@"发生网络请求 --> 获取验证码");
    if (userTF.text.length == 0) {
        [DialogTool showDlg:@"手机号不能为空"];
        return;
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:userTF.text forKey:@"mobile"];
        //        NSLog(@"dic-%@",dic);
        //        NSLog(@"33333333-----%@",API(APISendYzm));
        [PPNetworkHelper POST:@"" parameters:dic success:^(id responseObject) {
            //            NSLog(@"responseObject--%@",responseObject);
            NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if ([str isEqualToString:@"1"]) {
                [self.countDowntor startTask];
            }
            [DialogTool showDlg:responseObject[@"msg"]];

            //            NSLog(@"responseObject=%@",responseObject);
        } failure:^(NSError *error) {
            //            NSLog(@"error---%@",error);
            [DialogTool showDlg:@"加载失败"];

        }];
    }
}
/*
 *注册按钮点击方法实现
 */
- (void)buttonResign {
    [self.view endEditing:YES];
    NSLog(@"%@-------%@",user,pw);
    if (user.length == 0) {
        [DialogTool showDlg:@"请输入账号"];

        return;
    }
//    if (yzmStr.length == 0) {
//        [DialogTool showDlg:@"请输入验证码"];
//
//        return;
//    }
    if (pw.length == 0) {
        [DialogTool showDlg:@"请输入密码"];
        
        return;
    }
    if (pwAgain.length == 0) {
        [DialogTool showDlg:@"密码不一致"];
        
        return;
    }
    EMError *error = [[EMClient sharedClient] registerWithUsername:user password:pw];
    if (error==nil) {
        NSLog(@"注册成功");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        NSLog(@"error-----1111-----%@",error);
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
    yzmStr = theTextField.text;
    
}
-(void)textFieldDidChange2 :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    pw = theTextField.text;
    
}
-(void)textFieldDidChange3 :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    pwAgain = theTextField.text;
    
}
-(void)CountDownTimer:(dispatch_source_t)timer time:(NSInteger)time{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(time != 0){
            self->buttonGetYZM.enabled = NO;
            [self->buttonGetYZM setTitle:[NSString stringWithFormat:@"剩余%lds",time] forState:UIControlStateNormal];
        }else{
            self->buttonGetYZM.enabled = YES;
            [self->buttonGetYZM setTitle:@"重新获取" forState:UIControlStateNormal];
        }
    });
    
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
