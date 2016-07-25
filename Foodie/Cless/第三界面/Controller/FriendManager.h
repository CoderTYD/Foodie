//
//  FriendManager.h
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/23.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendManager : NSObject

@property (nonatomic, strong) NSMutableArray *friendsArray;
@property (nonatomic, strong) NSMutableArray *blackListArray;
@property (nonatomic, strong) NSMutableArray *dialogueArray; 
+ (instancetype)shareFriendManager;

@end
