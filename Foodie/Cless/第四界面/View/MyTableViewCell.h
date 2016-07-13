//
//  MyTableViewCell.h
//  豆瓣APP
//
//  Created by 唐半仙丶 on 16/6/29.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyTableViewCell_Identify @"MyTableViewCell_Identify"

@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;


@property (strong, nonatomic) IBOutlet UILabel *subContentLabel;

@end
