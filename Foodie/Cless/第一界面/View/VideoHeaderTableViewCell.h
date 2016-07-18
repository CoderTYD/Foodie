//
//  VideoHeaderTableViewCell.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VideoHeaderTableViewCell_Identifler @"VideoHeaderTableViewCell_Identifler"

@protocol pushDelegate <NSObject>

-(void)push;

@end

@interface VideoHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id<pushDelegate>delegate;


@end
