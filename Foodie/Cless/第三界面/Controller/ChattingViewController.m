//
//  ChattingViewController.m
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/23.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ChattingViewController.h"

@interface ChattingViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
EMChatManagerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
//所有消息
@property(nonatomic,strong)NSMutableArray*msgArr;
@property(nonatomic,strong)UITextView *msgTextView;

@end

@implementation ChattingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
