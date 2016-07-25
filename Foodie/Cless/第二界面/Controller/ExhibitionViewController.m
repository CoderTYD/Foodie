//
//  ExhibitionViewController.m
//  tabBar2
//
//  Created by 袁涛的大爷 on 16/7/19.
//  Copyright © 2016年 zhangzhen. All rights reserved.
//

#import "ExhibitionViewController.h"

@interface ExhibitionViewController ()
<
UIScrollViewDelegate
>
@property(nonatomic,strong)UILabel*label;
//@property(nonatomic,strong)UIScrollView*scrollV;
@end

@implementation ExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    UIScrollView*scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-80)];
    scrollV.backgroundColor=[UIColor blackColor];
    scrollV.pagingEnabled=YES;
    scrollV.bounces=NO;
//    scrollV.bouncesZoom=YES;
//    scrollV.minimumZoomScale=0.4;
//    scrollV.maximumZoomScale=2.5;
    scrollV.delegate=self;
    NSMutableArray*images=[NSMutableArray array];
    float imageHeights[20];
    int i=0;
    for (NSString*string in self.imageStrings) {
        UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
        float height = (float)self.view.frame.size.width/image.size.width*image.size.height;
        [images addObject:image];
        imageHeights[i]=height;
        i++;
    }
    scrollV.contentSize=CGSizeMake(self.imageStrings.count*self.view.frame.size.width, self.view.frame.size.height-80);
    for (int j=0; j<self.imageStrings.count; j++) {
        UIImageView*imageV=[[UIImageView alloc] init];
        imageV.frame=CGRectMake(j*self.view.frame.size.width, (self.view.frame.size.height-imageHeights[j])/2, self.view.frame.size.width, imageHeights[j]);
        [imageV setImage:images[j]];
        imageV.userInteractionEnabled=YES;
        [scrollV addSubview:imageV];
    }

    scrollV.contentOffset=CGPointMake(self.initialPage*self.view.frame.size.width, 0);
    [self.view addSubview:scrollV];

    self.label=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80,self.view.frame.size.height-80, 80, 80)];
    self.label.text=[NSString stringWithFormat:@"%ld/%ld",self.initialPage+1,self.imageStrings.count];

    [self.label setTextColor:[UIColor whiteColor]];
    [self.view addSubview:self.label];

    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [scrollV addGestureRecognizer:tap];
    
    

}

-(void)tap{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.label setText:[NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/self.view.frame.size.width+1,self.imageStrings.count]];
}


#warning 此处缩放待施工
//#pragma mark =====缩放的代理方法=====
////返回一个将要缩放的视图
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    return [[scrollView subviews] firstObject];
//}
////将要开始缩放
//-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
//    NSLog(@"将要开始缩放 %.1f",scrollView.zoomScale);
//    
//}
//-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    if (scrollView.zoomScale<1) {
//        self.rootview.imageview.center=self.rootview.scrollview.center;
//    }else{
//        CGRect temp=self.rootview.imageview.frame;
//        temp.origin=CGPointMake(0, 0);
//        self.rootview.imageview.frame=temp;
//    }
//}
//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"1");
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
