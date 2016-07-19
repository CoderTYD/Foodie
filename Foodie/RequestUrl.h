//
//  RequestUrl.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/12.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

//首页视频   推荐视频列表
#define VideoMeunRequest_URL @"http://api105.meishi.cc/v5/video_recipe.php?format=json?lon=&source=android&sort=1&lat=&page=3&format=json&"
//首页视频    美食家视频列表
#define VideoGourmetRequest_URL(ID)  [NSString stringWithFormat:@"http://api.meishi.cc/v5/video_detail.php?format=json?lon=&source=android&lat=&id=%@&page=1&format=json&",ID]



#endif /* RequestUrl_h */
