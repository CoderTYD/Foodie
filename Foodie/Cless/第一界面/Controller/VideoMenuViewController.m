//
//  VideoMenuViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoMenuViewController.h"
#import "VideoMenuTableViewCell.h"
#import "VideoHeaderTableViewCell.h"
#import "VideoWedViewController.h"
#import "VideoRecommandViewController.h"
#import "VideoMenuRequest.h"
#import "VideoMenuModel.h"
@interface VideoMenuViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    buttonClicked
>

//
@property (strong, nonatomic) IBOutlet UITableView *videoTableView;


@property (strong, nonatomic)NSMutableArray *videoMenuArray;

@end

@implementation VideoMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.videoTableView.dataSource = self;
    self.videoTableView.delegate = self;
    //清除 cell 上面的空白
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    //注册 cell
    [self.videoTableView registerNib:[UINib nibWithNibName:@"VideoMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoMenuTableViewCell_Identifler];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"VideoHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoHeaderTableViewCell_Identifler];
    
    [self videoRequest];
    
}
//数据请求
- (void)videoRequest{
    

    self.videoMenuArray = [NSMutableArray array];
    
    VideoMenuRequest *request = [[VideoMenuRequest alloc]init];
    
    [request videoMenuRequestWithParameter:nil success:^(NSDictionary *dic) {
       
        NSArray *array = dic[@"obj"][@"video_list"];
        for (NSDictionary *tempDic in array) {
            VideoMenuModel *model = [VideoMenuModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.videoMenuArray addObject:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.videoTableView reloadData];
            });
        }
        
        NSLog(@"%@",self.videoMenuArray);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


//cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.videoMenuArray.count -1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 150;
        
    }else{
        
        return 250;
    }
    
  
}

//跳转到
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row) {
        
        VideoWedViewController *webVC = [[VideoWedViewController alloc]init];
        VideoMenuModel *model = self.videoMenuArray[indexPath.row];
        webVC.vurlString = model.vurl;

        [self.navigationController pushViewController:webVC animated:YES];
        
    }
    
}


//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    if (indexPath.row == 0) {
        //头视图
        VideoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoHeaderTableViewCell_Identifler forIndexPath:indexPath];
        cell.delegate=self;
        return cell;
        
    }else{
        
        VideoMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoMenuTableViewCell_Identifler forIndexPath:indexPath];
        
        VideoMenuModel *model = self.videoMenuArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    
}

-(void)videoRecommandRequest:(NSString*)string{
    UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    VideoRecommandViewController *RecommandVC = [sb instantiateViewControllerWithIdentifier:@"VideoRecommandViewController"];
    RecommandVC.modelID = string;
    [self.navigationController pushViewController:RecommandVC animated:YES];
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
