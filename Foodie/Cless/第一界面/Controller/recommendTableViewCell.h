//
//  recommendTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define recommendTableViewCell_Identifier @"recommendTableViewCell_Identifier"
@interface recommendTableViewCell : UITableViewCell

//背景图片
@property (strong, nonatomic) IBOutlet UIImageView *cellBackImage;

//大标题
@property (strong, nonatomic) IBOutlet UILabel *bigLabel;

//小标题
@property (strong, nonatomic) IBOutlet UILabel *smallLabel;


@end
