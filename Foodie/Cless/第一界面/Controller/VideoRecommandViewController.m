//
//  VideoRecommandViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoRecommandViewController.h"
#import "VideoDetailHeaderTableViewCell.h"
#import "VideoMenuTableViewCell.h"
#import "VideoHeaderTableViewCell.h"
@interface VideoRecommandViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //注册 ce gt6ll
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoDetailHeaderTableViewCell_Identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoMenuTableViewCell_Identifler];
    
    
}

//cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        return 150;
    }else{
        return 250;
    }
}
//返回 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        VideoDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoDetailHeaderTableViewCell_Identifier forIndexPath:indexPath];
        return cell;
        
    }else{
        
        VideoMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoMenuTableViewCell_Identifler forIndexPath:indexPath];
    return cell;
    }
    
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
