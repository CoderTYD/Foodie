//
//  TasteTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteModel.h"

#define TasteTableViewCell_Identifier @"TasteTableViewCell_Identifier"

@interface TasteTableViewCell : UITableViewCell

//图片
@property (strong, nonatomic) IBOutlet UIImageView *photoImage;
//头像
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (nonatomic, strong) TasteModel *model;

@end
