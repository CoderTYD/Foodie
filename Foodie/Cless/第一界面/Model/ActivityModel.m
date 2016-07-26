//
//  ActivityModel.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel



-(NSString *)description{
    
    return [NSString stringWithFormat:@"ID -> %@",self.Id];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"Id"]) {
        _Id = value;
        
    }
    
    
}
@end
