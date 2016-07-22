//
//  MyViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/13.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "LoginsViewController.h"
@interface MyViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>


//头像
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

//图片数组
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSArray *labelArr;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //圆角
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.width / 2.0;
    

    // 设置代理
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    //注册 Cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_Identify];
    
  
    //右边设置按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mine-setting-icon"] style:(UIBarButtonItemStyleDone) target:self action:@selector(setupBarAction:)];
    [self setNavigationBarType];
    
    
    [self addRightNavigationItem];
    
}


//登录按钮
- (void)addRightNavigationItem{
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"登录" forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(0, 0, 40, 30);
    [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.21 blue:0.15 alpha:1.00] forState:UIControlStateNormal];
    // 选中时字体颜色
    [btn setTitleColor:[UIColor colorWithRed:1.00 green:0.44 blue:0.81 alpha:1.00] forState:(UIControlStateHighlighted)];
    
    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

-(void)rightBarItemClicked:(UIButton *)btn{
    
    NSLog(@"rightBarItemClicked");
    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    LoginsViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginsViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:loginVC animated:YES completion:^{
        
        
        
    }];
    
    
}


//右边设置按钮点击事件
- (void)setupBarAction:(UIBarButtonItem *)sender{
    
    
    NSLog(@"第四页面,设置按钮");
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.labelArr.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_Identify];
        cell.imageView.image = self.imagesArr[indexPath.row] ;
        cell.textLabel.text = self.labelArr[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
        return cell;

}
#pragma make-懒加载
- (NSArray *)imagesArr{
    
    if (!_imagesArr) {
        _imagesArr = @[
                       [UIImage imageNamed:@"mc_human_service_hl"],
                       [UIImage imageNamed:@"mc_photo_hl"],
                       [UIImage imageNamed:@"mc_gift_hl"],
                       [UIImage imageNamed:@"mc_order_nl"],
                       [UIImage imageNamed:@"mc_baby_hl"],
                       
                       ];
    }
    return _imagesArr;
}

#pragma make -懒加载

- (NSArray *)labelArr{
    
    if (!_labelArr) {
        _labelArr = @[@"我的信息",@"我的相册",@"我的礼物",@"我的订单",@"关于应用"];
    }
    return _labelArr;
}



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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
