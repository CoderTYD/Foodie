//
//  RegisterViewController.m
//  环信- 即时通讯
//
//  Created by 唐半仙丶 on 16/7/5.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "LoginsViewController.h"
#import "EMSDK.h"
#import "RegistersViewController.h"
@interface LoginsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation LoginsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- 登录按钮的点击方法
- (IBAction)login:(id)sender {
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.userName.text password:self.passWord.text];
    
    if (!error) {
        
        NSLog(@"登录成功");
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else{
        
        NSLog(@"登录失败");
        
    }
    
    
}

//点击 X号返回前一界面
- (IBAction)BackButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

//跳转到注册页面
- (IBAction)pushButton:(UIButton *)sender {
    
    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    RegistersViewController *registerVC = [mainSb instantiateViewControllerWithIdentifier:@"RegistersViewController"];
    //模态样式
    registerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:registerVC animated:YES completion:^{
      }];
    
  
    
    
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
