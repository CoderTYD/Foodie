//
//  SubtitleTableViewCell.h
//  Foodie
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubtitleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *burdenLabel;
@property (strong, nonatomic) IBOutlet UILabel *introLabel;
@property (strong, nonatomic) IBOutlet UIImageView *albumImageView;

@end
