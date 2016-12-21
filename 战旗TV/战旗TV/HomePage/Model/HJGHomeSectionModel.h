//
//  HJGHomeSectionModel.h
//  战旗TV
//
//  Created by 黄建国 on 2016/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJGCollectionCellModel.h"
@interface HJGHomeSectionModel : NSObject

@property (nonatomic, strong) NSString *channelIds;

@property (nonatomic, strong) NSString *gameIds;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *lists;

@property (nonatomic, strong) NSString *moreUrl;

@property (nonatomic, strong) NSString *nums;

@end
