//
//  HJGVideoPlayMenueView.h
//  战旗TV
//
//  Created by 黄建国 on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJGVideoPlayMenueView;
@protocol HJGVideoPlayMenueViewDelegate <NSObject>

- (void)playMenueView:(HJGVideoPlayMenueView *)playMenueView contentOffsetX:(CGFloat)offsetX;

@end
@interface HJGVideoPlayMenueView : UIView

@property (nonatomic, weak) id<HJGVideoPlayMenueViewDelegate> delegate;


//设置scroll的偏移量
- (void)setScrollViewOffset:(CGPoint)point;


@end
