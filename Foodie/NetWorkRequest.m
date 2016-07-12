//
//  NetWorkRequest.m
//  豆瓣APP
//
//  Created by 唐半仙丶 on 16/6/27.
//  Copyright © 2016年 Tang. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest



-(void)requestWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameterDic
      SuccessResponse:(SuccessResponse)success
      FailureResponse:(FailureResponse)failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //content-type: "text/html"报错信息,类型不匹配
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
   
}


//登录请求
- (void)sendDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
        SuccessResponse:(SuccessResponse)success
        FailureResponse:(FailureResponse)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
    
    [manager POST:url  parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
    
    
    
}

//注册请求
//上床图片

- (void)sendImageWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
                  image:(UIImage *)uploadimage
        SuccessResponse:(SuccessResponse)success
        FailureResponse:(FailureResponse)failure{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager POST:url parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        /**
         *  图片上传
         *
         *  @param uploadimage 需要上传的图片
         *  @param 0.5         压缩比例
         *  @param mimeType
         *  @return <#return value description#>
         */
        [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadimage, 0.5) name:@"avatar" fileName:@"avater.jpg" mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
    
    
    
}

@end
