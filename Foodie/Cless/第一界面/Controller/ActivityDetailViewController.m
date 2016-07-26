//
//  ActivityDetailViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailModel.h"
#import "ActivityDetailRequest.h"
@interface ActivityDetailViewController ()
//图片
@property (strong, nonatomic) IBOutlet UIImageView *Image;
//标题
@property (strong, nonatomic) IBOutlet UILabel *Title;
//时间
@property (strong, nonatomic) IBOutlet UILabel *PartyTime;
//剩余时间
@property (strong, nonatomic) IBOutlet UILabel *LastDays;
//参与人数
@property (strong, nonatomic) IBOutlet UILabel *UserNum;
//活动简介
@property (strong, nonatomic) IBOutlet UILabel *Summary;
//活动详情
@property (strong, nonatomic) IBOutlet UILabel *Detail;

@property (strong, nonatomic) NSMutableArray *detailArr;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewheight;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    
    NSLog(@" hou %@",self.modelID);
    [self ActivityDetailRequestData:self.modelID];
    NSLog(@"2");
}


//数据解析
- (void)ActivityDetailRequestData:(NSString *)ID{
    
    
    ActivityDetailRequest *request = [[ActivityDetailRequest alloc]init];
    
    NSLog(@"1");
    
            __weak typeof(self) weakSelf = self;
            [request activityDetailRequestWithParameter:@{@"Id":ID} scuccess:^(NSDictionary *dic) {
            NSLog(@"3");
            NSLog(@"activityDetail --> %@",dic);
            
            
//            
//                ActivityDetailModel *model = [[ActivityDetailModel alloc]init];
//                [weakSelf.model setValuesForKeysWithDictionary: dic[@"result"]];
                
               [weakSelf.Image setImageWithURL:[NSURL URLWithString:dic[@"result"][@"Image"]]];
                weakSelf.Title.text = dic[@"result"][@"Title"];
                
                weakSelf.PartyTime.text = dic[@"result"][@"PartyTime"];
                weakSelf.LastDays.text = [NSString stringWithFormat:@"剩余时间%@天",dic[@"result"][@"LastDays"]];
                weakSelf.UserNum.text = [NSString stringWithFormat:@"活动名额%@个",dic[@"result"][@"UserNum"]];
                weakSelf.Summary.text = dic[@"result"][@"Summary"];
                
                
                
                NSArray*array=dic[@"result"][@"Detail"];
                NSMutableString*mString=[NSMutableString string];
                for (NSString*string in array) {
                    [mString appendString:string];
                    [mString appendString:@"\n"];
                }
                
                weakSelf.Detail.text = mString;
                
                
                
                

        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];
  
    
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.viewheight.constant = CGRectGetMaxY(self.Detail.frame) +49;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation





@end
