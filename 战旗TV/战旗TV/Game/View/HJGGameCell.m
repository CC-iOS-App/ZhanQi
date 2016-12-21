//
//  HJGGameCell.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGGameCell.h"
@interface HJGGameCell()

@property (nonatomic, strong) UIImageView *topImage;

@property (nonatomic, strong) UILabel *titleLab;

@end
@implementation HJGGameCell

- (void)setModel:(HJGGameCellModel *)model{
    _model = model;
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@"liveImage"]];
    self.titleLab.text = model.name;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    self.topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH - W(40))/3.0, H(120))];
    self.topImage.image = [UIImage imageNamed:@"liveImage"];
    [self.contentView addSubview:self.topImage];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topImage.frame) + H(7), CGRectGetWidth(self.topImage.frame), H(15))];
    self.titleLab.text = @"专题标题";
    self.titleLab.font = [UIFont systemFontOfSize:W(12)];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLab];

}
@end
