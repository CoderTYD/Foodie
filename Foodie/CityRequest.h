//
//  CityRequest.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"
@interface CityRequest : NSObject
-(void)cityRequestWithID:(NSString*)ID
                 success:(SuccessResponse)success
                 failure:(FailureResponse)failure;
@end
