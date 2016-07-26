//
//  ActivityRequest.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityRequest : NSObject




- (void)ActivityRequestWithParameter:(NSString *)paramter
                            scuccess:(SuccessResponse)success
                             failure:(FailureResponse)failure;


@end
