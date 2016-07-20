//
//  LickRequest.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LickRequest : NSObject


- (void)likeRequestWithParameter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure;
@end
