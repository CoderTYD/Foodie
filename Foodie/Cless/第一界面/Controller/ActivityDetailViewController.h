//
//  ActivityDetailViewController.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@class ActivityDetailModel;
@interface ActivityDetailViewController : UIViewController

//
//
@property (nonatomic, copy) NSString *modelID;

//
@property (nonatomic, strong) ActivityModel *model;

@end
