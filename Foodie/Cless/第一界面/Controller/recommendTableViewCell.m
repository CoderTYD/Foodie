//
//  recommendTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "recommendTableViewCell.h"

@implementation recommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    self.cellBackImage.layer.cornerRadius = 10.0;
    self.cellBackImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
