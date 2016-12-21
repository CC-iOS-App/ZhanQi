//
//  HJGHomeCycleView.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGHomeCycleView.h"
#import "SDCycleScrollView.h"
#import "HJGCycleListModel.h"
@interface HJGHomeCycleView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleView;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) NSMutableArray *roomIdArr;

//@property (nonatomic, strong) NSMutableArray *urlArr;
@end

@implementation HJGHomeCycleView

- (void)setTitleData:(NSString *)titleData{
    _titleData = titleData;
    self.title.text = titleData;
}

- (void)setPhotoData:(NSArray *)photoData{
    _photoData = photoData;
    NSMutableArray *imageArr = [NSMutableArray array];
    self.roomIdArr = [NSMutableArray array];
//    self.urlArr = [NSMutableArray array];
    for (HJGCycleListModel *model in photoData) {
        [imageArr addObject:model.spic];
        [self.roomIdArr addObject:model.roomId];
//        [self.urlArr addObject:model.ID];
    }
    
    self.cycleView.imageURLStringsGroup = imageArr;
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

- (void)firstLoading{
    self.cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, H(170))];
    self.cycleView.backgroundColor = [UIColor redColor];
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleView.dotColor = [UIColor redColor];
    self.cycleView.placeholderImage = [UIImage imageNamed:@"ic_logo_big"];
    SDCycleScrollView *cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, H(170))];
    self.cycleView.delegate = self;
    [cycleView addSubview:self.cycleView];
    [self addSubview:cycleView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cycleView.frame) + H(10), 6, 26)];
    lineView.backgroundColor = [UIColor colorWithHexRGB:0x589FF5];
    [self addSubview:lineView];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + W(4), CGRectGetMaxY(self.cycleView.frame) + H(10), WIDTH - 40, 26)];
    self.title.text = @"组的标题";
    self.title.font = [UIFont boldSystemFontOfSize:20];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(homeCycleView:roomId:)]) {
        [_delegate homeCycleView:self roomId:self.roomIdArr[index]];
    }

}

@end
