//
//  HJGTabBarController.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGTabBarController.h"
#import "HJGNavigationController.h"
#import "HJGHomePageController.h"
#import "HJGLiveController.h"
#import "HJGGameController.h"
#import "HJGMineController.h"

@interface HJGTabBarController ()

@end

@implementation HJGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];

}

+ (void)initialize{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

}

- (void)setupChildViewController{
    HJGHomePageController *homePageVC = [[HJGHomePageController alloc]init];
    [self setOneChildController:homePageVC title:@"首页" nomarlImage:@"tabbar_home" selectedImage:@"tabbar_home_sel"];
    HJGLiveController *liveVC = [[HJGLiveController alloc]init];
    [self setOneChildController:liveVC title:@"直播" nomarlImage:@"tabbar_room" selectedImage:@"tabbar_room_sel"];
    HJGGameController *gameVC = [[HJGGameController alloc]init];
    [self setOneChildController:gameVC title:@"游戏" nomarlImage:@"tabbar_game" selectedImage:@"tabbar_game_sel"];
    HJGMineController *mineVC = [[HJGMineController alloc]init];
    [self setOneChildController:mineVC title:@"我的" nomarlImage:@"tabbar_me" selectedImage:@"tabbar_me_sel"];

}

- (void)setOneChildController:(UIViewController *)vc title:(NSString *)title nomarlImage:(NSString *)nomarlImage selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:nomarlImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[HJGNavigationController alloc]initWithRootViewController:vc]];
    
}

@end
