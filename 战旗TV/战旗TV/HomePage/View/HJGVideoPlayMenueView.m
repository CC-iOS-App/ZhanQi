//
//  HJGVideoPlayMenueView.m
//  战旗TV
//
//  Created by 黄建国 on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGVideoPlayMenueView.h"
#import "HJGVideoPlayAvatarView.h"
#import "HJGVideoPlayChatView.h"
#import "HJGVideoPlayActivityView.h"
#import "HJGVideoPlayPaihangView.h"
#define SCROLLVIEWHEIGHT HEIGHT
@interface HJGVideoPlayMenueView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *playScrollContentView;

@property (nonatomic, strong) HJGVideoPlayAvatarView *avatarView;

@property (nonatomic, strong) HJGVideoPlayChatView *chatView;

@property (nonatomic, strong) HJGVideoPlayActivityView *activityView;

@property (nonatomic, strong) HJGVideoPlayPaihangView *paihangView;

@end

@implementation HJGVideoPlayMenueView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 绘制视图
- (void)setupUI{

    self.playScrollContentView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, SCROLLVIEWHEIGHT)];
    self.playScrollContentView.contentSize = CGSizeMake(WIDTH * 4, SCROLLVIEWHEIGHT);
    self.playScrollContentView.pagingEnabled = YES;
    self.playScrollContentView.delegate = self;
    [self addSubview:self.playScrollContentView];
    
    self.avatarView = [[HJGVideoPlayAvatarView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, SCROLLVIEWHEIGHT)];
    [self.playScrollContentView addSubview:self.avatarView];
    
    self.chatView = [[HJGVideoPlayChatView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, SCROLLVIEWHEIGHT)];
    [self.playScrollContentView addSubview:self.chatView];
    
    self.activityView = [[HJGVideoPlayActivityView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH , SCROLLVIEWHEIGHT)];
    [self.playScrollContentView addSubview:self.activityView];
    
    self.paihangView = [[HJGVideoPlayPaihangView alloc]initWithFrame:CGRectMake(WIDTH*3 , 0, WIDTH, SCROLLVIEWHEIGHT)];
    [self.playScrollContentView addSubview:self.paihangView];

}


#pragma mark - 设置scroll偏移量
- (void)setScrollViewOffset:(CGPoint)point{
    self.playScrollContentView.contentOffset = point;
}

#pragma mark - scroll偏移量代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_delegate respondsToSelector:@selector(playMenueView:contentOffsetX:)]) {
        [_delegate playMenueView:self contentOffsetX:scrollView.contentOffset.x];
    }

}


@end
