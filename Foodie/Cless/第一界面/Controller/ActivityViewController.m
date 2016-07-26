//
//  ActivityViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityModel.h"
#import "ActivityRequest.h"
#import "ActivityDetailViewController.h"
@interface ActivityViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *activityTableView;
@property (strong, nonatomic) NSMutableArray * activityArr;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //清除 cell 上面的空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.activityTableView.dataSource = self;
    self.activityTableView.delegate = self;
    
    [self.activityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActivityTableViewCell_Identifier];


    [self activityRequestData];
}
//数据解析
- (void)activityRequestData{
    
    self.activityArr = [NSMutableArray array];
    
    ActivityRequest *request = [[ActivityRequest alloc]init];
    
    __weak typeof(self) weakSelf = self;
    [request ActivityRequestWithParameter:nil scuccess:^(NSDictionary *dic) {
        
        NSLog(@"ActivityRequest --> %@",dic);
        NSArray *array = dic[@"result"][@"List"];
        for (NSDictionary *dic in array) {
            
            ActivityModel *model = [[ActivityModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.activityArr addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.activityTableView reloadData];
        });
        

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.activityArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityTableViewCell_Identifier forIndexPath:indexPath];
    
    ActivityModel *model = self.activityArr[indexPath.row];

    cell.model = model;
    

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    //
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ActivityDetailViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"ActivityDetailViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    ActivityModel*model= self.activityArr[indexPath.row];
    loginVC.modelID=model.Id;
    NSLog(@" qian %@",loginVC.modelID);
    [self.navigationController pushViewController:loginVC animated:YES];
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
