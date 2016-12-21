//
//  HJGHomeSectionModel.m
//  战旗TV
//
//  Created by 黄建国 on 2016/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGHomeSectionModel.h"

@implementation HJGHomeSectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"lists" : @"HJGCollectionCellModel"
             };
}
@end
