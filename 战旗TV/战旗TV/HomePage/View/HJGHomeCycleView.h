//
//  HJGHomeCycleView.h
//  战旗TV
//
//  Created by 黄建国 on 2016/9/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGCycleListModel.h"
@class HJGHomeCycleView;
@protocol HJGHomeCycleViewDelegate <NSObject>

- (void)homeCycleView:(HJGHomeCycleView *)homeCycleView roomId:(NSString *)roomId;

@end

@interface HJGHomeCycleView : UICollectionReusableView

@property (nonatomic, strong) NSArray *photoData;

@property (nonatomic, strong) NSString *titleData;

@property (nonatomic, weak) id<HJGHomeCycleViewDelegate> delegate;

@end
