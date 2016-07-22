//
//  TasteRequest.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TasteRequest : NSObject


- (void)tasteRequestWithParmeter:(NSDictionary *)parameter
                         success:(SuccessResponse)success
                         failure:(FailureResponse)failure;
@end
