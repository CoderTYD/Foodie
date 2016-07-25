//
//  MenuView.m
//  Foodie
//
//  Created by 袁涛的大爷 on 16/7/24.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "MenuView.h"

@interface MenuView()<AddMemberDelegate>
//<UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,strong)UIButton*btn1;
@end


@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        self.backgroundColor=[UIColor clearColor];
//        self.menu=[[UITableView alloc]initWithFrame:CGRectMake(264, 0, 150, 100) style:(UITableViewStyleGrouped)];
//        self.backgroundColor=[UIColor purpleColor];
////        self.menu.delegate=self;
////        self.menu.dataSource=self;
////        [self.menu registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        [self addSubview:self.menu];
        self.backgroundColor=[UIColor clearColor];
        UIButton*button1=[[UIButton alloc] initWithFrame:CGRectMake(264, 0, 150, 50)];
        [button1 setTitle:@"添加好友" forState:(UIControlStateNormal)];
        [button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        button1.backgroundColor=[UIColor darkGrayColor];
        [button1 addTarget:self action:@selector(clickedButton1) forControlEvents:(UIControlEventTouchUpInside)];
        button1.titleLabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:button1];
        self.backgroundColor=[UIColor clearColor];
        UIButton*button2=[[UIButton alloc] initWithFrame:CGRectMake(264, 50, 150, 50)];
        [button2 setTitle:@"添加黑名单" forState:(UIControlStateNormal)];
        [button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        button2.backgroundColor=[UIColor darkGrayColor];
        button2.titleLabel.textAlignment=NSTextAlignmentLeft;
        [button2 addTarget:self action:@selector(clickedButton2) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button2];
    }
    return self;
}

-(void)clickedButton1{
    [self.delegate addFriend];
}
-(void)clickedButton2{
    [self.delegate addBlackList];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate foldMenu];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.backgroundColor=[UIColor blackColor];
//    if (indexPath.row) {
//        cell.textLabel.text=@"添加黑名单";
//    }else{
//        cell.textLabel.text=@"添加好友";
//    }
//    [cell.textLabel setTextColor:[UIColor whiteColor]];
//    return cell;
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [self dealloc];
//    NSLog(@"1");
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
