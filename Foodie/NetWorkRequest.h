//
//  NetWorkRequest.h
//  豆瓣APP
//
//  Created by 唐半仙丶 on 16/6/27.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "BaseRequest.h"
//成功回调
typedef void(^SuccessResponse)(NSDictionary *dic);
//失败回调
typedef void(^FailureResponse)(NSError *error);

@interface NetWorkRequest : BaseRequest

/**
 *  数据请求
 *
 *  @param url           请求数据的 url
 *  @param parameterDic  请求的参数
 *  @param success       成功回调的 BLock
 *  @param failure       失败回调的 block
 */
- (void)requestWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameterDic
      SuccessResponse:(SuccessResponse)success
      FailureResponse:(FailureResponse)failure;


//登录
- (void)sendDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
        SuccessResponse:(SuccessResponse)success
        FailureResponse:(FailureResponse)failure;
//注册
- (void)sendImageWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
                  image:(UIImage *)uploadimage
        SuccessResponse:(SuccessResponse)success
        FailureResponse:(FailureResponse)failure;

@end
