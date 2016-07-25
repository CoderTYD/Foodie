//
//  CityRequest.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "CityRequest.h"

@implementation CityRequest


-(void)cityRequestWithID:(NSString*)ID
                 success:(SuccessResponse)success
                 failure:(FailureResponse)failure{
    NetWorkRequest*request=[NetWorkRequest new];
    [request requestWithUrl:[NSString stringWithFormat:@"https://api.chishapp.com/stream?china_loc=116.343527%%2C40.030529&uuid=FFFFFFFF-D994-3565-FFFF-FFFFAE0A537B&context_id=-1&city_id=%@&current_city_id=48",ID] parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}




@end
