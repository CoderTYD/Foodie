//
//  VideoMenuTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoMenuTableViewCell.h"

@implementation VideoMenuTableViewCell

- (void)awakeFromNib {

    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width / 2;
    
    self.imgVideo.layer.cornerRadius = 10.0;



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
