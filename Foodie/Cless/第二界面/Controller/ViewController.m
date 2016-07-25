//
//  ViewController.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/18.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "ViewController.h"
#import "DrawerListView.h"
#import "CityRequest.h"
#import "CityModel.h"
#import "ExhibitionViewController.h"
#import "HotelDetailViewController.h"
#import "DetailViewController.h"


@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
showCaricature2

>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray*cityArr;
@property(nonatomic,strong)NSDictionary*cityDic;
@property(nonatomic,assign)BOOL isRight;
@property(nonatomic,strong)DrawerListView*drawerView;

@property(nonatomic,assign)CGPoint startPoint;

@property(nonatomic,assign)NSInteger currentIndexPathRow;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//        self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.alpha=1;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //    UINavigationController*a=[sb instantiateViewControllerWithIdentifier:@"navi"];
    //    [a.navigationBar setBarTintColor:[UIColor blueColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor brownColor]];
    
//    self.view.userInteractionEnabled=YES;
    self.currentIndexPathRow=-1;
    self.isRight=NO;
    self.cityArr=@[@"北京",@"上海",@"深圳",@"广州",@"天津",@"重庆",@"苏州",@"武汉",@"成都",@"杭州",@"南京",@"西安",@"长沙",@"大连",@"哈尔滨",@"兰州",@"济南",@"南阳"];
    self.cityDic=@{@"北京":@"48",@"上海":@"7",@"深圳":@"209",@"广州":@"122",@"天津":@"89",@"重庆":@"303",@"苏州":@"260",@"武汉":@"181",@"成都":@"140",@"杭州":@"168",@"南京":@"51",@"西安":@"227",@"长沙":@"315",@"大连":@"87",@"哈尔滨":@"73",@"南阳":@"57",@"兰州":@"44",@"济南":@"198"};
    NSLog(@"%ld",self.cityDic.allValues.count);
    
    self.tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.bounces=NO;
    self.tableView.separatorColor=[UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
//    NSLog(@"%f",self.view.bounds.size.width);
    self.drawerView=[[DrawerListView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, 300, self.view.bounds.size.height)];
    self.drawerView.userInteractionEnabled=YES;
    [self.view addSubview:self.drawerView];
//    NSLog(@"initial center %@",NSStringFromCGPoint(self.drawerView.center));
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startPoint=CGPointMake(264 , 368);
    UIPanGestureRecognizer*pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.drawerView addGestureRecognizer:pan];
    //    pan.cancelsTouchesInView 让<触摸取消><按压取消>马上被发送给所有识别触摸按压的视图 在这些方法被调用之前
    self.drawerView.delegate=self;
}
-(void)showCaricature2:(NSInteger)which imageStrings:(NSMutableArray *)imageStrings{
    
        ExhibitionViewController*exhibitPicture=[ExhibitionViewController new];
        exhibitPicture.initialPage=which;
        exhibitPicture.imageStrings=imageStrings;
    [self presentViewController:exhibitPicture animated:YES completion:^{
        
    }];
}
-(void)jumpToDetail:(NSString*)string{
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    HotelDetailViewController*hotelVC=[storybboard instantiateViewControllerWithIdentifier:@"HotelDetailViewController"];
//    [self.navigationController pushViewController:hotelVC animated:YES];
    DetailViewController*detailVC=[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//    DetailViewController*detailVC=[DetailViewController new];
    detailVC.city_id=self.cityDic[self.cityArr[self.currentIndexPathRow]];
    detailVC.ID=string;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%ld",self.cityDic.allValues.count);
    return self.cityDic.allValues.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.selectionStyle=
    cell.textLabel.text=[NSString stringWithFormat:@"    %@",self.cityArr[indexPath.row]];
    cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    cell.separatorInset=UIEdgeInsetsMake(1, 0, 0, 1);
//    if (cell.selected) {
//        cell.highlighted=YES;
//    }else{
//        cell.highlighted=NO;
//    }
    
    UIView*view=[[UIView alloc]init];
//    cell.
    view.backgroundColor=[UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00];
    cell.selectedBackgroundView=view;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

#pragma mark 界面滑动
-(void)rightDrawer{
    if (!self.isRight) {
        self.drawerView.userInteractionEnabled=YES;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [self.view bringSubviewToFront:self.drawerView];
            self.drawerView.frame=CGRectMake(114, 0, 300, self.view.frame.size.height);
            
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"收回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backDrawer)];
        } completion:^(BOOL finished) {
            self.isRight=YES;
            self.startPoint=CGPointMake(264, 368);
        }];
    }
}

-(void)backDrawer{
    if (self.isRight) {
        self.drawerView.userInteractionEnabled=NO;
        [self.navigationItem.rightBarButtonItem setTitle:@"弹出"];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [self.view bringSubviewToFront:self.drawerView];
            self.drawerView.frame=CGRectMake(414, 0, 300, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            self.isRight=NO;
            
            
        }];
    }else{
        [self rightDrawer];
    }
    
}
#pragma mark 手势
-(void)handlePan:(UIPanGestureRecognizer*)sender{
    
    CGPoint point=[sender translationInView:self.drawerView];
    
    if (point.x>0) {
        
        CGPoint currentPoint=CGPointMake(0, 368);
        currentPoint.x=self.startPoint.x+point.x;
        NSLog(@"%@ %@",NSStringFromCGPoint(point),NSStringFromCGPoint(currentPoint));
        self.drawerView.center=currentPoint;
        if (sender.state==UIGestureRecognizerStateEnded) {
            if (point.x>150) {
                //            self.isRight=!self.isRight;
                [self backDrawer];
                
            }else{
                self.isRight=!self.isRight;
                [self rightDrawer];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"?");
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row!=self.currentIndexPathRow) {
        
        NSString*cityName=self.cityArr[indexPath.row];
        CityRequest*cityRequest=[CityRequest new];
//        NSLog(@"%@",self.cityDic[cityName]);
        [cityRequest cityRequestWithID:self.cityDic[cityName] success:^(NSDictionary *dic) {
//            NSLog(@"success dic = %@",dic);
            [self.drawerView.dataArray removeAllObjects];
            NSArray*array=dic[@"results"];

            for (int i=0; i<array.count; i++) {
                NSDictionary*anyDic=array[i];
                CityModel*citymodel=[CityModel new];
                [citymodel setValuesForKeysWithDictionary:anyDic];
                if (citymodel.text!=nil) {
                    [self.drawerView.dataArray addObject:citymodel];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.drawerView.tableView reloadData];
                [self rightDrawer];
            });
        } failure:^(NSError *error) {
            NSLog(@"error %@",error);
        }];
        self.drawerView.tableView.contentOffset=CGPointMake(0, 0);
        self.currentIndexPathRow=indexPath.row;
    }
    
   
}





@end