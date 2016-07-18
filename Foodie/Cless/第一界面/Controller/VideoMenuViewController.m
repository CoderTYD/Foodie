//
//  VideoMenuViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoMenuViewController.h"
#import "VideoMenuTableViewCell.h"

@interface VideoMenuViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

//
@property (strong, nonatomic) IBOutlet UITableView *videoTableView;



@end

@implementation VideoMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.videoTableView.dataSource = self;
    self.videoTableView.delegate = self;
    
    [self.videoTableView registerNib:[UINib nibWithNibName:@"VideoMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoMenuTableViewCell_Identifler];
}


//cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 250;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoMenuTableViewCell_Identifler forIndexPath:indexPath];
    
    
    return cell;
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
