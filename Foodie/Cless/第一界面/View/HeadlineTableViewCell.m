//
//  HeadlineTableViewCell.m
//  Foodie
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "HeadlineTableViewCell.h"

@implementation HeadlineTableViewCell

- (void)awakeFromNib {

    [self reloadInputViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
