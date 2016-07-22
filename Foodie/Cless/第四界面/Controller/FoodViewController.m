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
#import "VideoWedViewController.h"
#import "LikeModel.h"
#import "LickRequest.h"
#import "TasteViewController.h"

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
//view 高度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayout;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
//视频点击按钮
@property (strong, nonatomic) IBOutlet UIButton *videoButton;

//最热商品
@property(strong, nonatomic)NSArray *bigLabel;
@property(strong, nonatomic)NSArray *smallLabel;
@property(strong, nonatomic)NSArray *imageArray;
@property(strong, nonatomic)NSArray *webArray;
//解析数组
@property(strong, nonatomic)NSMutableArray *likeArray;

@end

@implementation FoodViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //
    RootViewController *vc = (RootViewController *)self.navigationController.parentViewController;
    [vc showTabBar];
}
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

    [self likeDataRequest];

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

//数据请求
- (void)likeDataRequest{
    
    self.likeArray  = [NSMutableArray array];
    
    LickRequest * request = [[LickRequest alloc]init];
    
    __weak typeof(self) weakSelf = self;
    [request likeRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *array = dic[@"obj"][@"customized"][@"data"];
        for (NSDictionary * tempDic in array) {
            LikeModel *model = [[LikeModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.likeArray addObject:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.collectionView reloadData];
            });
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"like -> %@",error);
    }];
    
}

//视频菜谱
- (IBAction)videoMenuButtonClick:(id)sender {
    
    
    NSLog(@"视频菜谱");
    
//    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    VideoMenuViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"VideoMenuViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController pushViewController:loginVC animated:YES];

}

//食趣
- (IBAction)tasterButtonClick:(id)sender {
    
    
    NSLog(@"食趣");
    
    //    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TasteViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"TasteViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
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
  
    cell.bigLabel.text = self.bigLabel[indexPath.row];
    cell.smallLabel.text = self.smallLabel[indexPath.row];
    cell.cellBackImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    return cell;
}
//cell 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",self.parentViewController);
    VideoWedViewController *wedVC = [[VideoWedViewController alloc]init];
    
    wedVC.vurlString = self.webArray[indexPath.row];
    RootViewController *vc = (RootViewController *)self.navigationController.parentViewController;
    
    [vc hideTabBar];
    
    [self.navigationController pushViewController:wedVC animated:YES];
    
}



#pragma mark --- collectionView

//cell 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.likeArray.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tyd" forIndexPath:indexPath];
    
    LikeModel *model = self.likeArray[indexPath.row];
    cell.model = model;
    
    return cell;
    
}



// 设置 scrollView 高度
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.viewHeightLayout.constant = CGRectGetMaxY(self.collectionView.frame) +100;
    
    
}


#pragma make -懒加载
    
- (NSArray *)bigLabel{
        
        if (!_bigLabel) {
            _bigLabel = @[@"吃货or饭桶",@"初伏温度要爆表",@"夏日特饮缤纷Menu"];
        }
        return _bigLabel;
    }
    
- (NSArray *)smallLabel{
    if (!_smallLabel) {
        
        _smallLabel = @[@"够胆来测!看看你是几星吃货",@"桑拿模式即将开始",@"约起来姐妹茶点 patrty"];
    }
    return _smallLabel;
}
- (NSArray *)imageArray{
    if (!_imageArray) {
        
        _imageArray = @[@"QQ20160716-0",@"QQ20160716-1",@"QQ20160716-2"];
    }
    return _imageArray;
}

- (NSArray *)webArray{
    if (!_webArray) {
        
        _webArray = @[
                      @"http://m.meishij.net/huodong/zt.php?zt_id=173&un=meishi_14688091154545%40meishijauto.com&pw=e1a1f801419a8eff7fcdb78339e69dc3",
                      @"http://m.meishij.net/huodong.php?hd=chufu2015&un=meishi_14688091154545%40meishijauto.com&pw=e1a1f801419a8eff7fcdb78339e69dc3",
                      @"http://m.meishij.net/huodong/zt.php?zt_id=181&un=meishi_14688091154545%40meishijauto.com&pw=e1a1f801419a8eff7fcdb78339e69dc3"
                      ];
    }
    return _webArray;
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
