//
//  FeatureView.h
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/3.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureView : UIView

/* 实例方法
 ** message: 展示信息
 ** timeCount: 倒计时计数
 */
- (id)initWithMessage:(NSString *)message andTimeCount:(NSInteger)timeCount;

//显示隐藏
- (void)featureShow;
- (void)featureHide;

@end
