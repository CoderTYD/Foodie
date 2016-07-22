//
//  MessageViewController.m
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageTableView.backgroundColor=[UIColor blueColor];
    self.friendsTableView.backgroundColor=[UIColor magentaColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePage:(UISegmentedControl *)sender {
    self.scrollView.contentOffset=CGPointMake(sender.selectedSegmentIndex*414, 0);
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
