//
//  TasteViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "TasteViewController.h"
#import "TasteTableViewCell.h"
#import "TasteRequest.h"
#import "TasteModel.h"
#import "VideoWedViewController.h"
@interface TasteViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *tasteTableView;
@property (strong, nonatomic) NSMutableArray *tasterArray;
@end

@implementation TasteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //清除 cell 上面的空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tasteTableView.dataSource = self;
    self.tasteTableView.delegate = self;
    //注册
    [self.tasteTableView registerNib:[UINib nibWithNibName:@"TasteTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TasteTableViewCell_Identifier];
    
    [self tasteRequestWithData];

}
//数据请求
- (void)tasteRequestWithData{
    
    self.tasterArray = [NSMutableArray array];
    
    TasteRequest *request = [[TasteRequest alloc]init];
    
    __weak typeof(self) WeakSelf = self;
    
    [request tasteRequestWithParmeter:nil success:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
       
        NSArray *array  = dic[@"data"];
               
        for (NSDictionary *tempDic in array) {
             TasteModel *model = [[TasteModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [WeakSelf.tasterArray addObject:model];
       
        }
          NSLog(@"数组 --> %@",WeakSelf.tasterArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [WeakSelf.tasteTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tasterArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 280;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TasteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TasteTableViewCell_Identifier forIndexPath:indexPath];
    
    TasteModel *model = self.tasterArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoWedViewController *webVC = [[VideoWedViewController alloc]init];
    TasteModel *model = self.tasterArray[indexPath.row];
    
    webVC.vurlString = model.f_s_type;
    
    NSLog(@"vurlString -> %@",webVC.vurlString);
    [self.navigationController pushViewController:webVC animated:YES];
    
    
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
