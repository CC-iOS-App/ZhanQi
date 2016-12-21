//
//  HJGPlayVideoView.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGPlayVideoView.h"

@implementation HJGPlayVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
