//
//  ActivityTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

#define ActivityTableViewCell_Identifier @"ActivityTableViewCell_Identifier"

@interface ActivityTableViewCell : UITableViewCell

//头像
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//副标题
@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;
//活动时间
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
//参与人数
@property (strong, nonatomic) IBOutlet UILabel *applyUserCountLabel;

//
@property (nonatomic, strong) ActivityModel *model;
@end
