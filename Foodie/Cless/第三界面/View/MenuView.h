//
//  MenuView.h
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/24.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMemberDelegate <NSObject>

-(void)addFriend;

-(void)addBlackList;

-(void)foldMenu;

@end

@interface MenuView : UIView
@property(nonatomic,strong)UITableView*menu;
@property(nonatomic,weak)id<AddMemberDelegate>delegate;
@end
