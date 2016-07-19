//
//  VideoMenuModel.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/19.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "BaseModel.h"

@interface VideoMenuModel : BaseModel

@property(nonatomic,strong)NSString *headTitle;
//
@property (nonatomic, copy) NSString *headImg;
//
@property (nonatomic, copy) NSString *HeadName;
//
@property (nonatomic, copy) NSString *ID;
//说明
@property (nonatomic, copy) NSString *describtion;
//播放时间和次数
@property (nonatomic, copy) NSString *play_times;
//视频时长
@property (nonatomic, copy) NSString *time_length;
//视频截图
@property (nonatomic, copy) NSString *img_video;
//更新时间
@property (nonatomic, copy) NSString *time;
//视频连接
@property (nonatomic, copy) NSString *vurl;
//头像图片
@property (nonatomic, copy) NSString *img;
//美食家 name
@property (nonatomic, copy) NSString *name;



@end
