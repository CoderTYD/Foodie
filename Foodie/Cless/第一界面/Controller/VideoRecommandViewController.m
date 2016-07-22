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
#import "VideoMenuModel.h"
#import "VideoGourmetRequest.h"
#import "VideoDetailTableViewCell.h"
#import "VideoWedViewController.h"
@interface VideoRecommandViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
buttonClicked
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *videoRecommandArray;

@property (nonatomic, strong) VideoMenuModel *model;

@end

@implementation VideoRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    //注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoDetailHeaderTableViewCell_Identifier];

    [self.tableView registerNib:[UINib nibWithNibName:@"VideoDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VideoDetailTableViewCell_Identifier];
    
    [self videoRecommandRequest:self.modelID];
}

//数据请求
- (void)videoRecommandRequest:(NSString *)ID{
    
    self.videoRecommandArray = [NSMutableArray array];
    
    VideoGourmetRequest *request = [[VideoGourmetRequest alloc]init];
    
    
    __weak typeof (self) weakSelf = self;
    
    [request videoGourmetRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        NSString *string1 = dic[@"obj"][@"describtion"];
        NSString *string2 = dic[@"obj"][@"img"];
        NSString *string3 = dic[@"obj"][@"name"];
        NSArray *array  = dic[@"obj"][@"video_list"];
        
        for (NSDictionary *tempDic in array) {
            
            VideoMenuModel *model = [[VideoMenuModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            model.headTitle =string1;
            model.headImg = string2;
            model.HeadName = string3;
            [weakSelf.videoRecommandArray addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.tableView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}


-(void)setIntroductionText:(NSString*)text{
    
    

    
}



//cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.videoRecommandArray.count -1;
}
//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0&&indexPath.section==0) {
        VideoMenuModel *model= [[VideoMenuModel alloc]init];
        
        return [self getHeightForOwnerDetailLabel:model.describtion]+80;
        
     
    }else{
        return 250;
    }
}

- (CGFloat)getHeightForOwnerDetailLabel:(NSString*)text{
    CGRect testRect = [text boundingRectWithSize:CGSizeMake(314, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.0]} context:nil];
    //判断，如果文本只有一行，直接返回cell自己高度
    if (testRect.size.height > 50) {
        return testRect.size.height;
        
    }
    return 100;
}
//返回 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        VideoDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoDetailHeaderTableViewCell_Identifier forIndexPath:indexPath];
        VideoMenuModel *model = self.videoRecommandArray[indexPath.row];
        cell.model = model;

        return cell;
        
    }else{
        
        VideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoDetailTableViewCell_Identifier forIndexPath:indexPath];
        
        VideoMenuModel *model = self.videoRecommandArray[indexPath.row];
        cell.model = model;
      
    return cell;
    }
    
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoWedViewController *webVC = [[VideoWedViewController alloc]init];
    VideoMenuModel *model = self.videoRecommandArray[indexPath.row];
    webVC.vurlString = model.vurl;
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
