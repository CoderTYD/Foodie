//
//  VideoHeaderTableViewCell.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/18.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "VideoHeaderTableViewCell.h"
#import "VideoRecommandViewController.h"
@implementation VideoHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)buttonA:(UIButton *)sender {
    
    
    [self buttonCommonClick];
}

- (IBAction)buttonB:(UIButton *)sender {
    [self buttonCommonClick];

}

- (IBAction)buttonC:(UIButton *)sender {
    [self buttonCommonClick];

    
}

- (IBAction)buttonD:(UIButton *)sender {
    [self buttonCommonClick];

    
}

- (IBAction)buttonE:(UIButton *)sender {
    [self buttonCommonClick];

}




- (void)buttonCommonClick{
    
    //跳转到登录界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    VideoRecommandViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"VideoRecommandViewController"];
    //模态样式
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    [self.navigationController pushViewController:loginVC animated:YES];
    [self.delegate push];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}





@end
