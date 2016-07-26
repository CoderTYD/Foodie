//
//  ActivityDetailRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityDetailRequest.h"

@implementation ActivityDetailRequest


- (void)activityDetailRequestWithParameter:(NSDictionary *)paramter
                            scuccess:(SuccessResponse)success
                             failure:(FailureResponse)failure{
    
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    NSString *ID = [paramter objectForKey:@"Id"];
    [request requestWithUrl:ActivityDetailRequest_URL(ID) parameters:paramter successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
}

@end
