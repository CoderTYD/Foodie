//
//  LikeCollectionViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "LikeCollectionViewCell.h"

@implementation LikeCollectionViewCell

- (void)awakeFromNib {

    
    self.bgImageView.layer.cornerRadius = 5.0;
    self.bgImageView.layer.masksToBounds = YES;

}

@end
