//
//  VideoMenuTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VideoMenuTableViewCell_Identifler @"VideoMenuTableViewCell_Identifler"

@interface VideoMenuTableViewCell : UITableViewCell

//头像
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

//视频截图
@property (strong, nonatomic) IBOutlet UIImageView *imgVideo;




@end
