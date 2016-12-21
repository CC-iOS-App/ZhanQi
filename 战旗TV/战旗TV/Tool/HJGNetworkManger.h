//
//  HJGNetworkManger.h
//  战旗TV
//
//  Created by 黄建国 on 2016/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^HJGRequestBlock)(YTKBaseRequest *request);
@interface HJGNetworkManger : NSObject

@property (nonatomic, weak) AFHTTPRequestOperation *operation;

//获取首页列表数据
- (void)getHomeListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;


//获取首页banner数据
- (void)getHomeBanderDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

//获取直播页面数据
- (void)getLiveListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

//获取游戏页面数据
- (void)getGameData:(NSString *)pageStr SuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;
@end
