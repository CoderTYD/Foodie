//
//  LikeModel.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "BaseModel.h"

@interface LikeModel : BaseModel

//id
@property (nonatomic, copy) NSString *ID;
//标题
@property (nonatomic, copy) NSString *title;
//图片
@property (nonatomic, copy) NSString *titlepic;

@end
