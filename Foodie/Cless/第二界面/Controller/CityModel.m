//
//  CityModel.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"brand"]) {
        BrandModel*model=[[BrandModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        _brandModel=model;
    }else if ([key isEqualToString:@"creator"]){
        CreatorModel*model=[[CreatorModel alloc]init];
        [model setValuesForKeysWithDictionary:value];
        _creatorModel=model;
    }
}
@end
