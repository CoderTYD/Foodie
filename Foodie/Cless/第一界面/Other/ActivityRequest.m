//
//  ActivityRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityRequest.h"

@implementation ActivityRequest




- (void)ActivityRequestWithParameter:(NSDictionary *)paramter
                            scuccess:(SuccessResponse)success
                             failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    
    [request requestWithUrl:ActivityRequest_URL parameters:paramter successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
}

@end
