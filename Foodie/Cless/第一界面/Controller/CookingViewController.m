//
//  CookingViewController.m
//  Foodie
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "CookingViewController.h"
#import "HeadlineTableViewCell.h"
#import "SubtitleTableViewCell.h"
#import "CookingStepViewController.h"

@interface CookingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *headlineTV;
@property (strong, nonatomic) IBOutlet UITableView *subtitleTV;
@property(nonatomic,strong)NSArray *headArray;
@property(nonatomic,strong)NSArray *headNameArray;
@property(nonatomic,strong)NSArray *foodListArray;
@property(nonatomic,strong)NSArray *whiteArray;
@property(nonatomic,strong)NSArray *redArray;


@end

@implementation CookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNameArray = @[@"家常菜",@"创意菜",@"快手菜",@"素菜",@"凉菜",@"烘焙",@"面食"];
    self.headArray = @[@"http://caipu.yjghost.com/index.php/query/read?menu=%E5%AE%B6%E5%B8%B8%E8%8F%9C&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%88%9B%E6%84%8F%E8%8F%9C&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%BF%AB%E6%89%8B%E8%8F%9C&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E7%B4%A0%E8%8F%9C&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%87%89%E8%8F%9C&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E7%83%98%E7%84%99&rn=15&start=0",
                       @"http://caipu.yjghost.com/index.php/query/read?menu=%E7%83%98%E7%84%99&rn=15&start=0]"];
    
    self.whiteArray = @[@"1.png",@"2.png",@"3",@"4",@"5",@"6",@"7"];
    self.redArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07"];
    

    self.headlineTV.bounces=NO;
    
    [self.headlineTV registerNib:[UINib nibWithNibName:@"HeadlineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    [self.subtitleTV registerNib:[UINib nibWithNibName:@"SubtitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell2"];

    //上来就请求一次 避免次级tableView为空
    [self requestSubtitleContent:self.headArray[0]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.headlineTV) {
        return self.headNameArray.count;
    }else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.headlineTV) {
        return 100;
    }else {
        return 120;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.headlineTV) {
        HeadlineTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell1.titleLabel.text=self.headNameArray[indexPath.row];

        cell1.imageV.frame=CGRectMake(25, 14, 50, 50);

            cell1.imageV.image = [UIImage imageNamed:self.redArray[indexPath.row]];
      
        cell1.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 99)];
        cell1.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

        
        return cell1;
        
    }else {
        
        SubtitleTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary*dic = self.foodListArray[indexPath.row];
        
        cell2.titleLabel.text = dic[@"title"];
        cell2.burdenLabel.text = dic[@"burden"];
        cell2.introLabel.text = dic[@"imtro"];
        
        [cell2.albumImageView setImageWithURL:[NSURL URLWithString:dic[@"albums"]] placeholderImage:nil];

        return cell2;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.headlineTV) {
        
        self.subtitleTV.contentOffset = CGPointMake(0, 0);
        NSString*urlString = self.headArray[indexPath.row];
        NSLog(@"urlString %@",urlString);
        self.headlineTV.remembersLastFocusedIndexPath = YES;

        //请求数据
        [self requestSubtitleContent:urlString];
        //button点击变白方法 此处待补充
        HeadlineTableViewCell*cell = [self.headlineTV cellForRowAtIndexPath:indexPath];
        cell.imageV.image = [UIImage imageNamed:self.whiteArray[indexPath.row]];
  
    }else{
        
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadlineTableViewCell*cell = [self.headlineTV cellForRowAtIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.redArray[indexPath.row]];
    
//    跳转
    if (tableView == self.subtitleTV) {
        [self performSegueWithIdentifier:@"pusCookingStep" sender:nil];
    }
    
    
    
}

-(void)requestSubtitleContent:(NSString*)string{
    NetWorkRequest*request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:string parameters:nil successResponse:^(NSDictionary *dic) {
        self.foodListArray = dic[@"result"][@"data"];
        //主线程中刷新次级tableView
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.subtitleTV reloadData];
        });
    } failureResponse:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
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
