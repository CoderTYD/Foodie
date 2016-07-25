//
//  CommentTableViewCell.h
//  二级界面
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#define CommentTableViewCell_Identifier @"CommentTableViewCell_Identifier"

@protocol showCaricature <NSObject>

-(void)showCaricature:(NSInteger)which
         imageStrings:(NSMutableArray*)imageStrings;

@end

@interface CommentTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *creatorAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *creatorDisplayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UILabel *brandDisplayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *upVotedCount;
@property (weak, nonatomic) IBOutlet UILabel *downVotedCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

@property(nonatomic,strong)NSMutableArray*imagesArray;
@property(nonatomic,strong)CityModel*model;

@property(nonatomic,strong)NSMutableArray*imageString;

@property(nonatomic,strong)id<showCaricature>delegate;

@end
