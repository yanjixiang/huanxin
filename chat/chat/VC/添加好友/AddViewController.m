//
//  AddViewController.m
//  chat
//
//  Created by 闫继祥 on 2018/8/4.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "AddViewController.h"
#import "EaseUI.h"
#import "LQPopUpView.h"

@interface AddViewController ()<UITextFieldDelegate>
@property (nonatomic,copy)NSString *str;
@end

@implementation AddViewController
//隐藏底部
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加好友";
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat h = rectOfStatusbar.size.height+self.navigationController.navigationBar.frame.size.height;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, h+20, SCREEN_WIDTH, 50)];
    back.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [self.view addSubview:back];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, back.width-40, back.height)];
//    tf.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    tf.layer.borderWidth = 1.0;
    [back addSubview:tf];
    tf.delegate = self;
    tf.placeholder = @"请输入您要添加的账号";
    [tf addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, back.height+back.y+30, self.view.frame.size.width-20, 45);
    button.backgroundColor = [UIColor colorWithHexString:@"#1296db"];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 22.5;
    button.clipsToBounds = YES;
    [button setTitleColor:yWhiteColor forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"确认添加" forState:(UIControlStateNormal)];
    
}

-(void)textField1TextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    self.str = textField.text;
    
}
- (void)button {
    [self.view endEditing:YES];
    EMError *error = [[EMClient sharedClient].contactManager addContact:self.str message:@"我想加您为好友"];
    if (!error) {
        NSLog(@"添加成功");
        
        LQPopUpView *popUpView = [[LQPopUpView alloc] initWithTitle:@"提示" message:@"添加成功"];
        
        [popUpView addBtnWithTitle:@"我知道了" type:LQPopUpBtnStyleDefault handler:^{
            // do something...
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [popUpView showInView:self.view preferredStyle:0];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
