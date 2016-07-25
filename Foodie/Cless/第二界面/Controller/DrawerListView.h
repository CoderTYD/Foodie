//
//  DrawerListView.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "CommentTableViewCell.h"

@protocol showCaricature2 <NSObject>

-(void)showCaricature2:(NSInteger)which
          imageStrings:(NSMutableArray*)imageStrings;

-(void)jumpToDetail:(NSString*)string;

@end

@interface DrawerListView : UIView<UITableViewDataSource,UITableViewDelegate,showCaricature>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,assign)NSInteger index;



//移动用
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,strong)NSMutableArray*imagesArray;

@property(nonatomic,strong)CityModel*model;

@property(nonatomic,weak)id<showCaricature2>delegate;
@end
