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
    self.imgVideo.layer.masksToBounds = YES;



}

-(void)setModel:(VideoMenuModel *)model{
    
    _model = model;
    
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.img]];
    self.nameLabel.text = model.name;
    [self.imgVideo setImageWithURL:[NSURL URLWithString:model.img_video]];
    self.describtionLabel.text = model.describtion;
    self.timeLabel.text = model.time;
    self.playTimesLabel.text = model.play_times;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
