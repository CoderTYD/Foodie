//
//  VideoWedViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoWedViewController.h"

@interface VideoWedViewController ()
{
    UIWebView *webView;
}
@property(strong, nonatomic)UIWebView *webV;

@end

@implementation VideoWedViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:0.41 green:0.48 blue:0.59 alpha:1.00];
//    
//    self.webV=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:self.webV];
//    [self addWeb:@"www.baidu.com"];
    
    
    
   self.webV = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.vurlString]];
    
    NSLog(@"%@",self.vurlString);
    [self.view addSubview: self.webV];
    [self.webV loadRequest:request];
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
