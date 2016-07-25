//
//  FriendManager.m
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/23.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "FriendManager.h"

@implementation FriendManager
static FriendManager *_friendManager;



+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _friendManager = [super allocWithZone:zone];
    });
    return _friendManager;
}

+ (instancetype)shareFriendManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _friendManager = [[self alloc] init];
    });
    return _friendManager;
}

//单例里的属性在此懒加载
- (NSMutableArray *)friendsArray{
    if (nil==_friendsArray) {
        _friendsArray=[NSMutableArray array];
    }
    return _friendsArray;
}
-(NSMutableArray *)blackListArray{
    if (nil==_blackListArray) {
        _blackListArray=[NSMutableArray array];
    }
    return _blackListArray;
}
-(NSMutableArray *)dialogueArray{
    if (nil==_dialogueArray) {
        _dialogueArray=[NSMutableArray array];
    }
    return _dialogueArray;
}


- (id)copyWithZone:(NSZone *)zone{
    return _friendManager;
}

@end
