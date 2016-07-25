//
//  CommentTableViewCell.m
//  二级界面
//
//  Created by 唐半仙丶 on 16/7/15.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "ExhibitionViewController.h"

@interface CommentTableViewCell ()

@end

@implementation CommentTableViewCell

-(NSMutableArray *)imageString{
    if (_imageString==nil) {
        _imageString=[NSMutableArray array];
    }
    return _imageString;
}

-(void)setModel:(CityModel *)model{
    _model=model;
    [_creatorAvatarImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.creatorModel.avatar]]]];

    _creatorDisplayNameLabel.text=model.creatorModel.display_name;
    _infoLabel.text=model.info;
#warning 此处星星待做 图画待做

    _brandInfoLabel.text=model.brandModel.info;
    _brandDisplayNameLabel.text=model.brandModel.display_name;
    _upVotedCount.text=[NSString stringWithFormat:@"%ld",model.up_voted_count];
    _downVotedCount.text=[NSString stringWithFormat:@"%ld",model.down_voted_count];
    _commentCount.text=[NSString stringWithFormat:@"%ld",model.comment_count];
    _imagesArray=model.reviews.mutableCopy;
    



    _textView.text=model.text;

    _collectionV.scrollEnabled=NO;
    _collectionV.dataSource=self;
    _collectionV.delegate=self;
    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"image"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    //_collectionV.collectionViewLayout = layout;
//    _collectionV.contentSize=CGSizeMake(300, (_imagesArray.count+1)/2*120+10);
    [_imageString removeAllObjects];
    [_collectionV reloadData];
    

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:cell.bounds];
//    NSLog(@"%@",self.imagesArray[indexPath.row]);
//    NSLog(@"every cell imagearray count %ld",self.imagesArray.count);
    NSString*imageStr=self.imagesArray[indexPath.row][@"image"];

    [imageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"1.jpg"]];

    [self.imageString addObject:imageStr];
    [cell addSubview:imageView];
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSLog(@" count %ld",self.imagesArray.count);
    return self.imagesArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate showCaricature:indexPath.row imageStrings:self.imageString];
    
}

- (void)awakeFromNib {
    self.creatorAvatarImageView.layer.masksToBounds=YES;
    self.creatorAvatarImageView.layer.cornerRadius=self.creatorAvatarImageView.frame.size.width / 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
