//
//  HotelDetailViewController.h
//  二级界面
//
//  Created by 唐半仙丶 on 16/7/13.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlphaBlock)(CGFloat alpha);

@interface HotelDetailViewController : UIViewController

@property (nonatomic, copy) AlphaBlock alphaBlock;

@end
