//
//  HJGVideoPlayAvatarView.m
//  战旗TV
//
//  Created by 黄建国 on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGVideoPlayAvatarView.h"

@implementation HJGVideoPlayAvatarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 绘制视图
- (void)setupUI{
    self.backgroundColor = [UIColor redColor];
}

@end
