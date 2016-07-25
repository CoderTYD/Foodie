//
//  BrandModel.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "BaseModel.h"

@interface BrandModel : BaseModel
@property(nonatomic,strong)NSString*display_name;
@property(nonatomic,assign)NSString *ID;
@property(nonatomic,strong)NSString*info;
@property(nonatomic,strong)NSDictionary*level;
@property(nonatomic,assign)double score;
@end
