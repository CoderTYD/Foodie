//
//  CookingViewController.m
//  Foodie
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "CookingViewController.h"
#import "HeadlineTableViewCell.h"
#import "SubtitleTableViewCell.h"

@interface CookingViewController ()
@property (strong, nonatomic) IBOutlet UITableView *headlineTV;
@property (strong, nonatomic) IBOutlet UITableView *subtitleTV;

@end

@implementation CookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.headlineTV registerNib:[UINib nibWithNibName:@"HeadlineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    [self.subtitleTV registerNib:[UINib nibWithNibName:@"SubtitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell2"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.headlineTV) {
        return 7;
    }else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.headlineTV) {
        return 100;
    }else {
        return 120;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeadlineTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    SubtitleTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    if (tableView == self.headlineTV) {
        return cell1;
    }else {
        return cell2;
    }
    
    
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
