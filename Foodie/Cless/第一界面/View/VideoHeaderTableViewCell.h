//
//  VideoHeaderTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VideoHeaderTableViewCell_Identifler @"VideoHeaderTableViewCell_Identifler"


@protocol buttonClicked <NSObject>
-(void)videoRecommandRequest:(NSString*)ID;


@end

@interface VideoHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id<buttonClicked>delegate;





@end
