//
//  VideoGourmetRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/19.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoGourmetRequest.h"

@implementation VideoGourmetRequest


- (void)videoGourmetRequestWithParameter:(NSDictionary *)parameter
                                 success:(SuccessResponse)success
                                 failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    
    NSString *ID = [parameter objectForKey:@"id"];
    
    [request sendDataWithUrl:VideoGourmetRequest_URL(ID) parameters:parameter successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];

    
}

@end
