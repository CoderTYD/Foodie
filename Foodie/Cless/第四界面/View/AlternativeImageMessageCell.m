//
//  AlternativeImageMessageCell.m
//  LessonHuanXin
//
//  Created by 袁涛的大爷 on 16/7/7.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "AlternativeImageMessageCell.h"

@implementation AlternativeImageMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.avatar.layer.cornerRadius=20;
    self.backLabel.layer.cornerRadius=10;
    self.avatar.layer.masksToBounds = YES;
    self.backLabel.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
