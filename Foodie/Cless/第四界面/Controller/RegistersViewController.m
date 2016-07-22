//
//  ViewController.m
//  即时通讯-环信
//
//  Created by 唐半仙丶 on 16/7/4.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "RegistersViewController.h"
#import "EMSDK.h"
#import "LoginsViewController.h"

@interface RegistersViewController ()<UITextFieldDelegate>
//用户名
@property (strong, nonatomic) IBOutlet UITextField *userName;
//密码
@property (strong, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation RegistersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

   self.userName.delegate = self;
    self.passWord.delegate = self;


}
#pragma mark --- 注册按钮的点击方法
- (IBAction)regiButton:(id)sender {
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userName.text password:self.passWord.text];
    
    if (error==nil) {
        
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功!" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
        
        
        NSLog(@"注册成功");
        //跳转到登录界面
//        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        
//        LoginsViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginsViewController"];
//        //模态样式
//        loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        
//        [self presentViewController:loginVC animated:YES completion:^{
//            
//            
//            
//        }];
//        

        
        
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
//        NSLog(@"注册失败");
    }
    
}

//点击键盘上return后调用
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    //隐藏键盘
    [textField resignFirstResponder];

    return YES;
}
- (IBAction)BackButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
