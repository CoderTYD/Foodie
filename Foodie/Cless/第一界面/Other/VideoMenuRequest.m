//
//  VideoMenuRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/19.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoMenuRequest.h"

@implementation VideoMenuRequest


//数据请求
- (void)videoMenuRequestWithParameter:(NSDictionary *)parameter
                              success:(SuccessResponse)success
                              failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    [request sendDataWithUrl:VideoMeunRequest_URL parameters:parameter successResponse:^(NSDictionary *dic) {
        
        success(dic);
        
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
    
}

@end
