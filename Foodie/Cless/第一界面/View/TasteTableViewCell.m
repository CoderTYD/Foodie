//
//  TasteTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "TasteTableViewCell.h"

@implementation TasteTableViewCell

- (void)awakeFromNib {

    self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2.0;
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.borderWidth = 3.0;
    self.avatarImage.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.5].CGColor;

}

-(void)setModel:(TasteModel *)model{
    
    _model = model;
    [self.photoImage setImageWithURL:[NSURL URLWithString:model.photo]];
    [self.avatarImage setImageWithURL:[NSURL URLWithString:model.userInfo.avatar]];
    self.titleLabel.text = model.title;
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
