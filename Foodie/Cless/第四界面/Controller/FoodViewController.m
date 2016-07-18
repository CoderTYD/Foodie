//
//  FoodViewController.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/13.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "FoodViewController.h"
#import "SDCycleScrollView.h"
#import "recommendTableViewCell.h"
#import "LikeCollectionViewCell.h"
#import "VideoMenuViewController.h"
@interface FoodViewController ()
<
    SDCycleScrollViewDelegate,
    UITableViewDataSource,
    UITableViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

//轮播图地图
@property (strong, nonatomic) IBOutlet UIView *foodView;
//今日推荐
@property (strong, nonatomic) IBOutlet UITableView *recommendTableView;
//背景图
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayout;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIButton *videoButton;





@end

@implementation FoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //设置代理
    self.recommendTableView.delegate = self;
    self.recommendTableView.dataSource = self;
    
    //设置代理人
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    

    

    //注册cell
    [self.recommendTableView registerNib:[UINib nibWithNibName:@"recommendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recommendTableViewCell_Identifier];
    //注册 collectionViewCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LikeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"tyd"];

    
    [self headCarouselView];
}



#pragma mark ---轮播图
- (void)headCarouselView{

    self.foodView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 200)];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 200);
    [self.foodView addSubview:demoContainerView];
    
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"http://img.netbian.com/file/2016/0219/182d174c52cc87d642025bbce00d8a89.jpg",
                                  @"http://img.netbian.com/file/20150511/2322e08bdd901e7352b41e8edd539442.jpg",
                                  @"http://img.netbian.com/file/2015/0718/775843254d7ea03c6d52633075dc14b9.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"所有叉烧，通通都到碗里来",
                        @"酸甜可口营养丰富奶酪蓝莓挞",
                        @"啃着吃，才过瘾！",
                        ];
    
    
    
    CGFloat w = self.view.bounds.size.width;
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [demoContainerView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    
}

//视频菜谱
- (IBAction)videoMenuButtonClick:(id)sender {
    
    
    NSLog(@"视频菜谱");
    
    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    VideoMenuViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"VideoMenuViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:loginVC animated:YES completion:^{
        
        
    }];
    
    
    //跳转到视频菜谱界面
    VideoMenuViewController *videoVC = [[VideoMenuViewController alloc]init];
    
    [self.navigationController pushViewController:videoVC animated:YES];

}




//轮播图点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
}
//cell 的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}

//返回 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    recommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTableViewCell_Identifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.cellBackImage.image = [UIImage imageNamed:@"QQ20160716-0.png"];
        
    }else if (indexPath.row == 1){
    
        cell.cellBackImage.image = [UIImage imageNamed:@"QQ20160716-1.png"];
 
    }else if (indexPath.row == 2){
        
        cell.cellBackImage.image = [UIImage imageNamed:@"QQ20160716-2.png"];
 
        
    }
    return cell;
}



#pragma mark --- collectionView

//cell 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 30;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tyd" forIndexPath:indexPath];
    return cell;
    
}

// 设置 scrollView 高度
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.viewHeightLayout.constant = CGRectGetMaxY(self.collectionView.frame) +100;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
