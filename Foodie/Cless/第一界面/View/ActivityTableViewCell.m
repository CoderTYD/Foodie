//
//  ActivityTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}




-(void)setModel:(ActivityModel *)model{
    
    _model = model;
    
    [self.imageV setImageWithURL:[NSURL URLWithString:model.Image]];
    self.titleLabel.text = model.Title;
    self.shopNameLabel.text = model.ShopName;
    self.timeLabel.text = model.Time;
    self.applyUserCountLabel.text = [NSString stringWithFormat:@"%@人参与",model.ApplyUserCount];
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
