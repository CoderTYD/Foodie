//
//  CityModel.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "BaseModel.h"
#import "CreatorModel.h"
#import "BrandModel.h"

@interface CityModel : BaseModel
@property(nonatomic,strong)CreatorModel*creatorModel;
@property(nonatomic,strong)NSString*info;
@property(nonatomic,strong)BrandModel*brandModel;
@property(nonatomic,strong)NSArray *reviews;
@property(nonatomic,strong)NSString*text;
@property(nonatomic,assign)NSInteger up_voted_count;
@property(nonatomic,assign)NSInteger down_voted_count;
@property(nonatomic,assign)NSInteger comment_count;
@property(nonatomic,assign)NSInteger star_count;


@end
