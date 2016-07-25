//
//  ShowView.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/21.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}
-(void)addAllViews{
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 80)];
    [self addSubview:self.imageView];
    self.label=[[UILabel alloc] initWithFrame:CGRectMake(5, 85, 85, 45)];
    [self addSubview:self.label];
    self.label.font=[UIFont systemFontOfSize:14.0];
    self.label.numberOfLines=0;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panAction)];
    [self.imageView addGestureRecognizer:tap];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self newDetailView];
}
-(void)panAction{
    [self newDetailView];
}
-(void)newDetailView{
    if (self.IDString) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newDetailView" object:nil userInfo:@{@"id":self.IDString}];
    }
}
@end
