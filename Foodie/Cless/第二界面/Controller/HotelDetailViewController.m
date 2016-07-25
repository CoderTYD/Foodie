//
//  HotelDetailViewController.m
//  二级界面
//
//  Created by 唐半仙丶 on 16/7/13.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "dituViewController.h"

@interface HotelDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (strong, nonatomic) IBOutlet UITableView *hotelDetailTableView;
@property (strong, nonatomic) IBOutlet UILabel *carLabel;

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootScrollView.bounces=NO;
   
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 设置设置代理
    self.hotelDetailTableView.dataSource = self;
    self.hotelDetailTableView.delegate = self;
    //注册 cell
    [self.hotelDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    //Label线框
    self.carLabel.layer.borderWidth = 0.5;
    self.carLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    
//    [self setNavigationBarType];
//    
//    
//    
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self setNavigationBarType];
}
-(void)viewDidDisappear:(BOOL)animated{
    //恢复导航栏及状态栏
}

// cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 2;
}


//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    if (indexPath.row == 0 ) {
        cell.imageView.image = [UIImage imageNamed:@"eatry_address"];
        cell.textLabel.text = @"北京市海淀区金五星大厦";
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"fond_ico"];
        cell.textLabel.text = @"010-63586698";

        
    }
    //cell 右边箭头样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}

//导航栏透明效果
- (void)setNavigationBarType{
    
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //跳转到地图页面
        dituViewController *dituVC = [[dituViewController alloc]init];
        [self.navigationController pushViewController:dituVC animated:YES];
        
    }else if (indexPath.row == 1){
        //调用电话
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
