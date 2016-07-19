//
//  VideoDetailTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/19.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoMenuModel.h"

#define VideoDetailTableViewCell_Identifier @"VideoDetailTableViewCell_Identifier"
@interface VideoDetailTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *img_video;

@property (strong, nonatomic) IBOutlet UILabel *describtion;

@property (strong, nonatomic) IBOutlet UILabel *play_times;


@property (strong, nonatomic) VideoMenuModel *model;

@end
