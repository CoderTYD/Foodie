//
//  MessageCell.h
//  
//
//  Created by 袁涛的大爷 on 16/7/6.
//
//

//#define messageCell_Identifier @"MessageCell_Identifier"
#import <UIKit/UIKit.h>



@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
