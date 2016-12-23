//
//  HJGVideoPlaySelectedView.h
//  战旗TV
//
//  Created by 黄建国 on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJGVideoPlaySelectedView;
@protocol HJGVideoPlaySelectedViewDelegate <NSObject>

- (void)selectedView:(HJGVideoPlaySelectedView *)selectedView int:(NSInteger)butTag;

@end

@interface HJGVideoPlaySelectedView : UIView


@property (nonatomic, weak) id<HJGVideoPlaySelectedViewDelegate> delegate;

- (void)setTiaoViewFrame:(CGRect)frame;


@end
