//
//  AlternativeMessageCell.m
//  LessonHuanXin
//
//  Created by 袁涛的大爷 on 16/7/6.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "AlternativeMessageCell.h"

@implementation AlternativeMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.imageV.layer.cornerRadius=20;
    self.label.layer.cornerRadius=10;
    self.imageV.layer.masksToBounds = YES;
    self.label.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
