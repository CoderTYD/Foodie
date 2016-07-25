//
//  RootViewController.h
//  豆瓣APP
//
//  Created by 唐半仙丶 on 16/6/28.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodieTabBar.h"


@interface RootViewController : UITabBarController

@property(nonatomic,strong)FoodieTabBar *dbTabBar;

- (void)showTabBar;
- (void)hideTabBar;
@end
