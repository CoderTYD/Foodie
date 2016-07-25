//
//  CreatorModel.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "BaseModel.h"

@interface CreatorModel : BaseModel
@property(nonatomic,strong)NSString*avatar;
@property(nonatomic,strong)NSString*display_name;
@property(nonatomic,assign)NSInteger ID;
//@property(nonatomic,strong)NSString*info;
@property(nonatomic,strong)NSDictionary*level;
@property(nonatomic,assign)NSInteger score;
@end
