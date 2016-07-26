//
//  ActivityDetailModel.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailModel : NSObject

//
@property (nonatomic, copy) NSString *Id;
//图片
@property (nonatomic, copy) NSString *Image;
//标题
@property (nonatomic, copy) NSString *Title;
//活动时间
@property (nonatomic, copy) NSString *PartyTime;
//剩余时间
@property (nonatomic, copy) NSString *LastDays;
//活动名额
@property (nonatomic, copy) NSString *UserNum;
//活动简介
@property (nonatomic, copy) NSString *Summary;
//活动详情
@property (nonatomic, copy) NSString *Detail;


@end
