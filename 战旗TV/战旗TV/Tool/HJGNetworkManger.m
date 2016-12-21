//
//  HJGNetworkManger.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGNetworkManger.h"

@implementation HJGNetworkManger
@synthesize operation;

- (void)getHomeListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operation = [manager GET:APPURL_HomeList parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"返回格式错误");
            return;
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        int code = [dic intForKey:@"code"];
        successBlock(code, dic);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];

}

- (void)getHomeBanderDataSuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operation = [manager GET:APPURL_HomeBanner parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"返回格式错误");
            return;
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        int code = [dic intForKey:@"code"];
        successBlock(code, dic);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

- (void)getLiveListDataSuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operation = [manager GET:APPURL_Live parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"返回格式错误");
            return;
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        int code = [dic intForKey:@"code"];
        successBlock(code, dic);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

- (void)getGameData:(NSString *)pageStr SuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *gameUrl = [NSString stringWithFormat:@"%@%@",APPURL_Game,pageStr];
    operation = [manager GET:gameUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"返回格式错误");
            return;
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        int code = [dic intForKey:@"code"];
        successBlock(code, dic);  
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}

@end
