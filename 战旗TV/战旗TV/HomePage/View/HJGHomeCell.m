//
//  HJGHomeCell.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGHomeCell.h"
@interface HJGHomeCell()

//liveImage
@property (nonatomic, strong) UIImageView *liveImage;

//简介
@property (nonatomic, strong) UILabel *introduceLable;

//男女图标
@property (nonatomic, strong) UIImageView *sexIcon;

//名字
@property (nonatomic, strong) UILabel *nameLable;

//人数
@property (nonatomic, strong) UILabel *personNumLable;


@end
@implementation HJGHomeCell

- (void)setModel:(HJGCollectionCellModel *)model{
    _model = model;
    [self.liveImage sd_setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@"liveImage"]];
    self.nameLable.text = model.nickname;
    self.introduceLable.text = model.title;
    self.personNumLable.text = model.online;
    if ([model.gender isEqualToString:@"1"]) {
        self.sexIcon.image = [UIImage imageNamed:@"icon_room_female"];
    }else{
        self.sexIcon.image = [UIImage imageNamed:@"icon_room_male"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self firstLoading];
}

#pragma mark - 控件初始化
- (void)firstLoading{
    self.liveImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH - W(40))/2.0, H(100))];
    self.liveImage.image = [UIImage imageNamed:@"liveImage"];
    [self.contentView addSubview:self.liveImage];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) - H(14), CGRectGetWidth(self.liveImage.frame), H(14))];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.5;
    [self.liveImage addSubview:grayView];
    
    self.introduceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) - H(14), CGRectGetWidth(self.liveImage.frame), H(14))];
    self.introduceLable.text = @"战旗TV主播介绍";
    self.introduceLable.textAlignment = NSTextAlignmentLeft;
    self.introduceLable.font = [UIFont systemFontOfSize:W(14)];
    self.introduceLable.textColor = [UIColor whiteColor];
    [self.liveImage addSubview:self.introduceLable];
    
    self.sexIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) + H(2), W(13), H(13))];
    self.sexIcon.image = [UIImage imageNamed:@"icon_room_male"];
    [self.contentView addSubview:self.sexIcon];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sexIcon.frame) + W(3), CGRectGetMaxY(self.liveImage.frame) + H(2), W(150), H(13))];
    self.nameLable.text = @"主播的昵称";
    self.nameLable.font = [UIFont systemFontOfSize:W(10)];
    self.nameLable.textColor = [UIColor lightGrayColor];
    self.nameLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLable];
    
    self.personNumLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.liveImage.frame) - W(40), CGRectGetMaxY(self.liveImage.frame) + H(2), W(40), H(13))];
    self.personNumLable.font = [UIFont systemFontOfSize:W(10)];
    self.personNumLable.textColor = [UIColor lightGrayColor];
    self.personNumLable.textAlignment = NSTextAlignmentLeft;
    self.personNumLable.text = @"1000";
    [self.contentView addSubview:self.personNumLable];
    
    
}

@end
