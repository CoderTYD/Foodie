//
//  LickRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "LickRequest.h"

@implementation LickRequest



- (void)likeRequestWithParameter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    
    [request sendDataWithUrl:LikeReque_URL parameters:parameter successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
}

@end
