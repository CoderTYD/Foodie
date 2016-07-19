//
//  VideoMenuTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoMenuModel.h"

#define VideoMenuTableViewCell_Identifler @"VideoMenuTableViewCell_Identifler"




@interface VideoMenuTableViewCell : UITableViewCell

//头像
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
//名字
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
//说明
@property (strong, nonatomic) IBOutlet UILabel *describtionLabel;
//视频截图
@property (strong, nonatomic) IBOutlet UIImageView *imgVideo;
//播放时长
@property (strong, nonatomic) IBOutlet UILabel *playTimesLabel;
//更新日期
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) VideoMenuModel *model;

@end
