//
//  TasteModel.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfo.h"
@interface TasteModel : BaseModel

//ID
@property (nonatomic, copy) NSString *ID;
//标题
@property (nonatomic, copy) NSString *title;
//网址 URL
@property (nonatomic, copy) NSString *f_s_type;
//图片
@property (nonatomic, copy) NSString *photo;
//收藏
@property (nonatomic, copy) NSString *fav_num;
//头像
@property (nonatomic, copy) NSString *avatar;
//
@property (nonatomic, copy) UserInfo *userInfo;


@end
