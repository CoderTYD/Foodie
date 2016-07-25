//
//  TasteRequest.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "TasteRequest.h"

@implementation TasteRequest


- (void)tasteRequestWithParmeter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure{
    

    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    
    [request sendDataWithUrl:TasteReque_URL parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
    
}

@end
