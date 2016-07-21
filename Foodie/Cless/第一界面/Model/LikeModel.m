//
//  LikeModel.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "LikeModel.h"

@implementation LikeModel
-(NSString *)description{
    
    return [NSString stringWithFormat:@"ID -> %@",self.ID];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
        
    }
    
    
}
@end
