//
//  CommonCell.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/20.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

- (void)awakeFromNib {
    // Initialization code
    self.supplementLabel.text=@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
