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

//横屏缩回按钮
@property (nonatomic, strong) UIButton *backSwtichBut;

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
    _swtichBtn  =  [UIButton ButtonWithRect:CGRectMake(WIDTH - 44, 240 , 44, 44) title:@"" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(swtichTouch) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [_swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:_swtichBtn];
    
    _backSwtichBut = [UIButton ButtonWithRect:CGRectMake(44, HEIGHT - 60, 44, 44) title:@"缩小" titleColor:[UIColor whiteColor] BackgroundImageWithColor:[UIColor clearColor] clickAction:@selector(backSwtichTouch) viewController:self titleFont:14 contentEdgeInsets:UIEdgeInsetsZero];
    [_backSwtichBut setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:_backSwtichBut];
    _backSwtichBut.hidden = YES;
}


//因为想要手动旋转，所以先关闭自动旋转
- (BOOL)shouldAutorotate{
    return NO;
}


- (void)swtichTouch{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    _playerView.frame = CGRectMake(0, 0, HEIGHT, WIDTH);
    _swtichBtn.hidden=YES;
    _backSwtichBut.hidden = NO;
    self.navigationController.navigationBarHidden=YES;
    
    //旋转屏幕，但是只旋转当前的View
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    _playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
    _playerView.center = self.view.center;
    
}

- (void)backSwtichTouch{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    _swtichBtn.hidden = NO;
    _backSwtichBut.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    //旋转屏幕，但是只旋转当前的View
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    _playerView.transform = CGAffineTransformIdentity;
    _playerView.frame = CGRectMake(0, 0, WIDTH, 320);
    

}

@end


