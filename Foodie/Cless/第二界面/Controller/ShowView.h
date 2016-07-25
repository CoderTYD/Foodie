//
//  ShowView.h
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/21.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Redirect <NSObject>

-(void)redicrect:(NSString*)string;

@end

@interface ShowView : UIView
@property(nonatomic,strong)NSString*IDString;

@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UILabel*label;

@property(nonatomic,strong)id<Redirect>delegate;
@end
