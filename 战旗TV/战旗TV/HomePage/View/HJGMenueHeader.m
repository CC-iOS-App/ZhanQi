//
//  HJGMenueHeader.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGMenueHeader.h"
@interface HJGMenueHeader()

@property (nonatomic, strong) UILabel *title;

@end

@implementation HJGMenueHeader

- (void)setTitleData:(NSString *)titleData{
    _titleData = titleData;
    self.title.text = titleData;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 7, 6, 26)];
    lineView.backgroundColor = [UIColor colorWithHexRGB:0x589FF5];
    [self addSubview:lineView];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + W(4), 7, WIDTH - 40, 26)];
    self.title.text = @"组的标题";
    self.title.font = [UIFont boldSystemFontOfSize:20];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];

}
@end
