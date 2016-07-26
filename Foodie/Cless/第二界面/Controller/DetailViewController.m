//
//  DetailViewController.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/20.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "DetailViewController.h"
#import "FirstHeaderCell.h"
#import "HeaderCommonCell.h"
#import "CommonCell.h"
#import "ShowView.h"
//地图
#import "JXMapNavigationView.h"
#import "MapViewController.h"
@interface DetailViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate

>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property(nonatomic,strong)UITableView*tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSString*imageStr;
@property(nonatomic,strong)NSString*display_name;
@property(nonatomic,strong)NSString*summary;

@property(nonatomic,strong)NSString*phone;
@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*coordination;
@property(nonatomic,strong)NSString*neighborhood;
@property(nonatomic,strong)NSString*avgPrice;
@property(nonatomic,strong)NSString*tags;

//@property(nonatomic,strong)NSArray*bundles;
@property(nonatomic,strong)NSArray*itemArr;
@property(nonatomic,strong)NSArray*brandArr;
//经纬度
@property(nonatomic,strong)NSString*longitude;
@property(nonatomic,strong)NSString*latitude;
@end

@implementation DetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setNavigationBarType];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
#warning 我特别想知道下面这个方法的用法
//    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCommonCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"HeaderCommonCell"];
//     Class:[UITableViewCell class] forCellReuseIdentifier:@"cell"]
    [self tableViewRegister];
    [self requestData];
   

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self determineNavigationBarType];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newDetailView:) name:@"newDetailView" object:nil];

   


}

-(void)tableViewRegister{
   [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCommonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeaderCommonCell"];
   [self.tableView registerNib:[UINib nibWithNibName:@"CommonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommonCell"];
   [self.tableView registerNib:[UINib nibWithNibName:@"FirstHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FirstHeaderCell"];
}



-(void)newDetailView:(NSNotification*)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   //    HotelDetailViewController*hotelVC=[storybboard instantiateViewControllerWithIdentifier:@"HotelDetailViewController"];
   //    [self.navigationController pushViewController:hotelVC animated:YES];
   DetailViewController*detailVC=[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//   DetailViewController*detailVC=[[DetailViewController alloc] init];
   detailVC.ID=notification.userInfo[@"id"];
   detailVC.city_id=self.city_id;
   [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)requestData{
   int a=0;
   do {
      [self requestDataA];
   } while (a++<5&&([self.display_name isKindOfClass:[NSNull class]]||self.display_name));
   [self requestDataB];
}


-(void)requestDataA{
    //外界变量在block中进行赋值必须加上__block
    //    __block BOOL firstRequest=NO;
    NetWorkRequest*request=[[NetWorkRequest alloc] init];
    [request requestWithUrl:[NSString stringWithFormat:@"https://api.chishapp.com/brand/%@?uuid=FFFFFFFF-D994-3565-FFFF-FFFFAE0A537B",self.ID] parameters:nil successResponse:^(NSDictionary *dic) {
        self.imageStr=dic[@"banner"];
        self.display_name=dic[@"display_name"];
        self.summary=dic[@"summary"];
        //        firstRequest=YES;
    } failureResponse:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
-(void)requestDataB{
    NetWorkRequest *interRequest=[NetWorkRequest new];
    [interRequest requestWithUrl:[NSString stringWithFormat:@"https://api.chishapp.com/brand/%@/information?china_loc=116.343494%%2C40.030521&uuid=FFFFFFFF-D994-3565-FFFF-FFFFAE0A537B&city_id=%@&current_city_id=48",self.ID,self.city_id] parameters:nil successResponse:^(NSDictionary *dic) {
        
        self.phone=dic[@"branch"][@"phone"];
        self.address=dic[@"branch"][@"address"];
        self.coordination=dic[@"branch"][@"china_loc"];
        self.neighborhood=dic[@"branch"][@"display_name"];
        self.avgPrice=dic[@"avg_price"];
        self.tags=dic[@"tags_description"];
        NSArray *bundles=dic[@"bundles"];
        self.display_name=[self validate:self.display_name];
        self.summary=[self validate:self.summary];
        self.phone=[self validate:self.phone];
        self.address=[self validate:self.address];
        self.coordination=[self validate:self.coordination];
        self.neighborhood=[self validate:self.neighborhood];
        self.avgPrice=[self validate:self.avgPrice];
        self.tags=[self validate:self.tags];
        for (NSDictionary*dic in bundles) {
            if ([dic[@"model_type"] isEqualToString:@"item"]) {
                self.itemArr=dic[@"models"];
               if (self.itemArr==NULL||[self.itemArr isKindOfClass:[NSNull class]]) {
                  self.itemArr=@[];
               }
            }else if ([dic[@"model_type"] isEqualToString:@"brand"]){
                self.brandArr=dic[@"models"];
               if (self.brandArr==NULL||[self.brandArr isKindOfClass:[NSNull class]]) {
                  self.brandArr=@[];
               }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@ %@ %@ %@ %@ %@ %@",self.summary,self.phone,self.address,self.coordination,self.neighborhood,self.avgPrice,self.tags);
            [self.tableView reloadData];
        });
    } failureResponse:^(NSError *error) {
        NSLog(@"error %@",error);
    }];

}



//内部改好像不管用 此处涉及机制 回去要思考
//内部不能改外部变量 外部只是传复制的数据过来 好像是最开始函数课上的内容
-(NSString*)validate:(NSString*)str{
    if ([str isKindOfClass:[NSNull class]]||str==NULL) {
        return @"暂无";
    }
    return str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//导航栏透明效果
- (void)setNavigationBarType{
    
//    self.navigationController.navigationBar.translucent = YES;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self determineNavigationBarType];
}

-(void)determineNavigationBarType{
    if (self.tableView.contentOffset.y>125) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    }
    if (self.tableView.contentOffset.y<250&&self.tableView.contentOffset.y>125) {
        self.navigationController.navigationBar.alpha=(self.tableView.contentOffset.y-125)/125.0;
    }
    if (self.tableView.contentOffset.y<125) {
        [self setNavigationBarType];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:{
            if ([self excludeNull:self.summary]) {
                return 2;
            }else{
                return 1;
            }
            break;
        }
        case 2:{
            return 6;
        }
        case 3:{
            return 2;
        }
        case 4:{
            return 2;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            FirstHeaderCell*cell=[tableView dequeueReusableCellWithIdentifier:@"FirstHeaderCell"];
           if (!([self.imageStr isKindOfClass:[NSNull class]]||self.imageStr==NULL)) {
              [cell.titleImageV setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"chi.jpg"]];
           }
           
            cell.titleLabel.text=self.display_name;
            
            return cell;
        }
        case 1:{
            if (!indexPath.row) {
                HeaderCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeaderCommonCell"];
                cell.headerLabel.text=@" 介绍";
//                cell.textLabel.numberOfLines=0;
                return cell;
            }else{
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
#pragma mark 我去你马勒戈壁 一个json里面你给我传两种null??? 我去你妈的
                //NSNull判断方式:直接输入原字符串//此处可能不对 应该是用类型判断
                //NULL判断方式:!=NULL
                if ((![self.summary isKindOfClass:[NSNull class]])&&self.summary!=NULL) {
#warning ????? 为什么加了判断还是不行
                    cell.textLabel.text=self.summary;
                }else{
                    cell.textLabel.text=@"暂无";
                }
                cell.textLabel.numberOfLines=0;
                NSLog(@"%.2f",cell.textLabel.frame.size.width);
                return cell;
            }
        }
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    HeaderCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeaderCommonCell"];
                    cell.headerLabel.text=@" 详细信息";
                    return cell;
                    break;
                }
                case 1:{
                    CommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
                    cell.optionLabel.text=@"附近";
                    cell.contentLabel.text=self.neighborhood;
                    NSLog(@"%.2f",cell.contentLabel.frame.size.width);
                    return cell;
                }
                case 2:{
                    CommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
                    cell.optionLabel.text=@"地址";
                    cell.contentLabel.text=self.address;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    return cell;
                }
                case 3:{
                    CommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
                    cell.optionLabel.text=@"电话";
                    cell.contentLabel.text=self.phone;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    return cell;
                }
                case 4:{
                    CommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
                    cell.optionLabel.text=@"人均";
//                    if ((![self.avgPrice isKindOfClass:[NSNull class]])&&self.avgPrice!=NULL) {
                    if (![self.avgPrice isEqual:@"暂无"]) {
                        cell.contentLabel.text=[NSString stringWithFormat:@"%@元",self.avgPrice];
                    }else{
                        cell.contentLabel.text=self.avgPrice;
                    }
                    return cell;
                }
                case 5:{
                    CommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
                    cell.optionLabel.text=@"标签";
                    if ((![self.tags isKindOfClass:[NSNull class]])&&self.tags!=NULL) {
                        cell.contentLabel.text=self.tags;
                    }else{
                        cell.contentLabel.text=@"暂无";
                    }
                    cell.contentLabel.numberOfLines=0;
                    return cell;
                }
            }
        }
        case 3:{
            if (indexPath.row==0) {
                HeaderCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeaderCommonCell"];
                cell.headerLabel.text=@"菜品";
                return cell;
            }else{
                UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
                UIScrollView*scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 2, 414, 138)];
                [cell.contentView addSubview:scrollV];
                scrollV.bounces=NO;
                scrollV.contentSize=CGSizeMake(self.itemArr.count*90, 138);
                for (int i=0; i<self.itemArr.count; i++) {
                    ShowView*showView=[[ShowView alloc] initWithFrame:CGRectMake(i*90, 0, 90, 138)];
                    showView.label.text=self.itemArr[i][@"info"];
                    [showView.imageView setImageWithURL:[NSURL URLWithString:self.itemArr[i][@"banner"]] placeholderImage:[UIImage imageNamed:@"chi.jpg"]];
                   [scrollV addSubview:showView];
                }
                return cell;
            }
        }
        case 4:{
          if (indexPath.row==0) {
             HeaderCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:@"HeaderCommonCell"];
             cell.headerLabel.text=@"喜欢它的人也喜欢";
             return cell;
          }else{
             UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
             UIScrollView*scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 2, 414, 158)];
             [cell.contentView addSubview:scrollV];
             scrollV.bounces=NO;
             scrollV.contentSize=CGSizeMake(self.itemArr.count*90, 158);
             for (int i=0; i<self.itemArr.count; i++) {
                ShowView*showView=[[ShowView alloc] initWithFrame:CGRectMake(i*90, 0, 90, 158)];
                showView.IDString=self.brandArr[i][@"id"];
                showView.label.text=self.brandArr[i][@"info"];
                [showView.imageView setImageWithURL:[NSURL URLWithString:self.brandArr[i][@"banner"]] placeholderImage:[UIImage imageNamed:@"chi.jpg"]];
                [scrollV addSubview:showView];
             }
             return cell;
          }
       }
    }
   
    return nil;
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 310;
    }
    if (indexPath.section==1&&indexPath.row==1) {
//        if ((![self.summary isKindOfClass:[NSNull class]])&&self.summary!=NULL) {
            return [self getHeightForOwnerDetailLabel:self.summary width:354 fontSize:17.0]*1.2;
        
    }
    if (indexPath.section==2&&indexPath.row==1) {
        if ((![self.address isKindOfClass:[NSNull class]])&&self.address!=NULL) {
            return [self getHeightForOwnerDetailLabel:self.address width:241 fontSize:17.0];
        }
    }
    if (indexPath.section==2&&indexPath.row==5) {
        if ((![self.address isKindOfClass:[NSNull class]])&&self.address!=NULL) {
            return [self getHeightForOwnerDetailLabel:self.tags width:241 fontSize:17.0]*1.2;
        }
    }
    if (indexPath.section==3&&indexPath.row==1) {
       if (self.itemArr.count) {
          return 140;
       }else{
          return 10;
       }
       
    }
   
   if (indexPath.section==4&&indexPath.row==1) {
      if (self.brandArr.count) {
         return 160;
      }else{
         return 10;
      }
    }
   
    return 48;
}
- (CGFloat)getHeightForOwnerDetailLabel:(NSString*)text
                                  width:(CGFloat)width
                               fontSize:(CGFloat)fontSize{
    CGRect testRect = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil];
    //判断，如果文本只有一行，直接返回cell自己高度
    if (testRect.size.height > 48) {
        return testRect.size.height;
    }
    return 48;
}

-(BOOL)excludeNull:(id)a{
    return (![a isKindOfClass:[NSNull class]])&&a!=NULL;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
   if (indexPath.section==2&&indexPath.row==2) {
      //地址
//      self.address
//      self.coordination
      self.longitude=[self.coordination substringToIndex:[self.coordination length]/2];
      self.latitude=[self.coordination substringFromIndex:[self.coordination length]/2+1];
      
      //地图 从当前地方到指定的地方
      JXMapNavigationView *vc = [[JXMapNavigationView alloc]init];
      
      double latitude = [self.latitude doubleValue];
      double longitude = [self.longitude doubleValue];
      
      NSLog(@"_____%@",self.latitude);
      NSLog(@"++++++%lf",latitude);
      [vc showMapNavigationViewFormcurrentLatitude:39.9200225351   currentLongitute:116.3968733177 TotargetLatitude:latitude targetLongitute:longitude toName:self.address];
       [self.view addSubview:vc];

   }
   if (indexPath.section==2&&indexPath.row==3) {
      //电话
      //2.返回一个是否拨打的请求(打电话前会弹出询问框)
      [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phone]]];
      
   }
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
