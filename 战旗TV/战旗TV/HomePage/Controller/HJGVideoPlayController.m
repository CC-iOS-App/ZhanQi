//
//  HJGVideoPlayController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGVideoPlayController.h"
#import <AVFoundation/AVFoundation.h>
#import "HJGPlayVideoView.h"
#import<MediaPlayer/MediaPlayer.h>
#import<CoreMedia/CoreMedia.h>
@interface HJGVideoPlayController ()

@property (nonatomic ,strong)AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) HJGPlayVideoView *playerView;
@property (nonatomic ,strong)  UIButton  *swtichBtn;
@property (nonatomic, assign) CATransform3D myTransform;

@end

@implementation HJGVideoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self createBasicConfig];
    [self playVideo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self hiddenNaviGation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

#pragma mark - 设置导航栏隐藏
- (void)hiddenNaviGation{
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - 播放视频
- (void)playVideo{
    NSString *filePath = [NSString stringWithFormat:@"%@%@.m3u8",VIDEO_URL , self.videoID];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *videoUrl = [NSURL URLWithString: filePath];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [self.playerView.player play];
}

- (void)createBasicConfig{
    
    _playerView=[[HJGPlayVideoView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 320)];
    _myTransform = _playerView.layer.transform;
    [self.view addSubview: _playerView];
    _swtichBtn  =  [UIButton ButtonWithRect:CGRectMake(WIDTH - 44, 250 , 44, 44) title:@"" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(swtichAction) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [_swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:_swtichBtn];
    
}

- (void)swtichAction{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _playerView.frame = CGRectMake(0, 0, HEIGHT, WIDTH);
    _swtichBtn.hidden=YES;
    
    self.navigationController.navigationBarHidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
        _playerView.layer.transform  =  transform;
        _playerView.center = self.view.center;
        self.navigationController.navigationBar.alpha=0;
        
    } completion:^(BOOL finished) {
        _playerView.center = self.view.center;
        
        self.navigationController.navigationBar.alpha=1;
        self.navigationController.navigationBar.hidden=NO;
    }];
}


@end


