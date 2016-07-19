//
//  VideoDetailTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/19.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoDetailTableViewCell.h"

@implementation VideoDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(VideoMenuModel *)model{
    _model = model;
    
    [self.img_video setImageWithURL:[NSURL URLWithString:model.img_video]];
    self.describtion.text = model.describtion;
    self.play_times.text = model.play_times;
    


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
