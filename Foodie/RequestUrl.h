//
//  RequestUrl.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/12.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h


//首页 猜你喜欢列表
#define LikeReque_URL @"http://api.meishi.cc/v5/index5.php?format=json?lon=&app_liketime=1468987929&source=android&page=2&lat=&format=json&"


//首页视频   推荐视频列表
#define VideoMeunRequest_URL @"http://api105.meishi.cc/v5/video_recipe.php?format=json?lon=&source=android&sort=1&lat=&page=3&format=json&"
//首页视频   美食家视频列表
#define VideoGourmetRequest_URL(ID)  [NSString stringWithFormat:@"http://api.meishi.cc/v5/video_detail.php?format=json?lon=&source=android&lat=&id=%@&page=1&format=json&",ID]
//首页食趣   菜谱列表
#define TasteReque_URL @"http://api.meishi.cc/v5/caidans_list1.php?lon=&source=android&t=3&lat=&page=1&format=json&uf=0&"


#endif /* RequestUrl_h */
