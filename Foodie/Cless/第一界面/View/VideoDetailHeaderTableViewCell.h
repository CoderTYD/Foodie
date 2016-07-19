//
//  VideoDetailHeaderTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoMenuModel.h"
#define VideoDetailHeaderTableViewCell_Identifier @"VideoDetailHeaderTableViewCell_Identifier"

@interface VideoDetailHeaderTableViewCell : UITableViewCell
//头像
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
//说明
@property (strong, nonatomic) IBOutlet UILabel *describtion;

@property (strong, nonatomic) VideoMenuModel *model;

@end
