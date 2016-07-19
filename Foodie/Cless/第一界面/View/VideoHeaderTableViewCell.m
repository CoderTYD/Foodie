//
//  VideoHeaderTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoHeaderTableViewCell.h"
#import "VideoRecommandViewController.h"

@interface VideoHeaderTableViewCell()

@end


@implementation VideoHeaderTableViewCell

- (void)awakeFromNib {





}





- (IBAction)buttonA:(UIButton *)sender {
    
    
    [self.delegate videoRecommandRequest:@"1"];
}

- (IBAction)buttonB:(UIButton *)sender {
    [self.delegate videoRecommandRequest:@"6"];

}

- (IBAction)buttonC:(UIButton *)sender {
    [self.delegate videoRecommandRequest:@"4"];

    
}

- (IBAction)buttonD:(UIButton *)sender {
  [self.delegate videoRecommandRequest:@"5"];

    
}

- (IBAction)buttonE:(UIButton *)sender {
   [self.delegate videoRecommandRequest:@"41"];

}


//
//
//- (void)buttonCommonClick{
//    
//    //跳转到登录界面
//    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    VideoRecommandViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"VideoRecommandViewController"];
//    //模态样式
//    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    
////    [self.navigationController pushViewController:loginVC animated:YES];
//    [self.delegate ];
//    
//    
//}
//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}





@end
