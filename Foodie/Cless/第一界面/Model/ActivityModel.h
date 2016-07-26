//
//  ActivityModel.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityModel : BaseModel


//
@property (nonatomic, copy) NSString *Id;
//标题
@property (nonatomic, copy) NSString *Title;
//副标题
@property (nonatomic, copy) NSString *ShopName;
//时间
@property (nonatomic, copy) NSString *Time;
//参与人数
@property (nonatomic, copy) NSString *ApplyUserCount;
//图片
@property (nonatomic, copy) NSString *Image;

@end
