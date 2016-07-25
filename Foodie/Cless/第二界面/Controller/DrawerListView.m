//
//  DrawerListView.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "DrawerListView.h"

@interface DrawerListView ()



@end

@implementation DrawerListView


-(NSMutableArray*)dataArray{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //cell间分割的风格
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.index=0;
        [self addViews];
    }
    return self;
}

//这里给数据源数组赋值
-(void)addViews{
    self.userInteractionEnabled=YES;

    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommentTableViewCell_Identifier];

    [self.tableView reloadData];
    
 
}

#pragma mark UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CommentTableViewCell_Identifier];

    CityModel*cityModel=self.dataArray[indexPath.row];
//    NSLog(@"aiy %@",cityModel.brandModel.ID);
    cell.model=cityModel;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.collectionV.frame=CGRectMake(cell.collectionV.frame.origin.x, cell.collectionV.frame.origin.y, 300, (cell.imagesArray.count+1)/2*120+10);
//    
//    cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 300, cell.textView.frame.size.height+cell.collectionV.contentSize.height+178);
//    NSLog(@"label:%.00f\n collection:%.0f\n frame:%.0f",cell.textView.frame.size.height,cell.collectionV.contentSize.height,cell.frame.size.height-178);
    cell.delegate=self;
//    NSLog(@"%@",cell.model.br1andModel.ID);
    return cell;
}

-(void)showCaricature:(NSInteger)which imageStrings:(NSMutableArray *)imageStrings{
    [self.delegate showCaricature2:which imageStrings:imageStrings];
}

-(void)sb{
    [self.tableView reloadData];
}

#pragma mark

//    //如果子视图的范围超出父视图的边界 那么超出部分将会被裁剪
//    imageView.clipsToBounds=YES;

#warning cell的高度最好不用在cell生成方法里面搞frame 而是直接在height里重走高度计算方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CityModel*cityModel=self.dataArray[indexPath.row];
    CGFloat textHeight=[self getHeightFor:cityModel.text];
    NSInteger imageCount=cityModel.reviews.count;
    CGFloat HEIGHT=194+textHeight+(imageCount+1)/2*130;
    return HEIGHT;
}


- (CGFloat)getHeightFor:(NSString*)ownerDetailLabel{
    CGRect testRect = [ownerDetailLabel boundingRectWithSize:CGSizeMake(280, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16.0]} context:nil];
    //判断，如果文本只有一行，直接返回cell自己高度
    if (testRect.size.height > 20) {
        return testRect.size.height;
    }
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    [self.delegate jumpToDetail:cell.model.brandModel.ID];
    
    
    
    
    
}









//原计划方法 弃用
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch*touch=[touches anyObject];
//    self.startPoint=[touch locationInView:self];
//}
//
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch*touch=[touches anyObject];
//    CGPoint destinationPoint=[touch locationInView:self];
//    CGPoint center=self.center;
//    CGFloat change=destinationPoint.x-self.startPoint.x;
//    center.x+=change;
//    if (center.x>150) {
//          self.center=center;
//    }
//}



@end
