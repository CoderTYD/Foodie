//
//  TasteModel.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/22.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "TasteModel.h"

@implementation TasteModel




-(NSString *)description{
    
    return [NSString stringWithFormat:@"ID -> %@ user ->%@",self.ID,self.userInfo];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
        
    }else if ([key isEqualToString:@"user_info"]){
        UserInfo *model = [[UserInfo alloc]init];
        
        [model setValuesForKeysWithDictionary:value];
        
        _userInfo = model;
        
    }
    
    
}
@end
