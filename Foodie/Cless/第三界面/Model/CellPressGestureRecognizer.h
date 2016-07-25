//
//  CellPressGestureRecognizer.h
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/25.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellPressGestureRecognizer : UILongPressGestureRecognizer
@property(nonatomic,assign)NSInteger indexPathRow;
@property(nonatomic,strong)NSString *friendID;
@end
