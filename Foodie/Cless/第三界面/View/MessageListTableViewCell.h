//
//  MessageListTableViewCell.h
//  UI_lesson_HuanxinJieMian
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 张健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *LastMsgLabel;
@property (nonatomic, strong) NSString *imageString;
@end
