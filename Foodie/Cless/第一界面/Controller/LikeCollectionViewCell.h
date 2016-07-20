//
//  LikeCollectionViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeModel.h"
//#define LikeCollectionViewCell_Identify @"LikeCollectionViewCell_Identify"

@interface LikeCollectionViewCell : UICollectionViewCell

//背景图片
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLable;

//
@property (nonatomic, strong)LikeModel *model;

@end
