//
//  DouBanTabBar.h
//  豆瓣APP
//
//  Created by 唐半仙丶 on 16/6/28.
//  Copyright © 2016年 Tang. All rights reserved.
//
@class FoodieTabBar;


@protocol FoodieTabBarDelegate <NSObject>

-(void)FoodieItemDidClicked:(FoodieTabBar *)tabBar;

@end

#import <UIKit/UIKit.h>



@interface FoodieTabBar : UITabBar


//当前选中的 TabBar 的下边
@property (nonatomic, assign) int currentSelected;
//当前选中的 item
@property (nonatomic, strong) UIButton *currentSelectedItem;
//TabBar上边的所有 item
@property (nonatomic, strong) NSArray  *allItems;


//
@property (nonatomic, weak) id<FoodieTabBarDelegate>foodieDelegate;



//初始化方法:根据 items
- (id)initWithItems:(NSArray *)items frame:(CGRect)frame;







@end
