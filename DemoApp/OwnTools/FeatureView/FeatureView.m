//
//  FeatureView.m
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/3.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import "FeatureView.h"

@implementation FeatureView
{
    NSString *sMessage;//要展示的信息
    NSInteger sTimeCount;//倒计时计数
    
    UILabel *timeCountLabel;//倒计时Label
    UILabel *messageShowLabel;//信息展示Label
    
    NSTimer *countTimer;//计时器
}

//实例方法
- (id)initWithMessage:(NSString *)message andTimeCount:(NSInteger)timeCount
{
    self=[super init];
    
    if (self)
    {
        sMessage = message;
        sTimeCount = timeCount;
        
        self.backgroundColor = [UIColor yellowColor];
        
        //添加子视图
        [self loadSelfSubViews];
    }
    
    return self;
}

//添加子视图 展示信息
- (void)loadSelfSubViews
{
    timeCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 80, 55, 60, 40)];
    timeCountLabel.textAlignment = NSTextAlignmentCenter;
    timeCountLabel.backgroundColor = [UIColor redColor];
    timeCountLabel.textColor = [UIColor whiteColor];
    timeCountLabel.font = [UIFont systemFontOfSize:20];
    timeCountLabel.layer.cornerRadius = 20;
    timeCountLabel.layer.masksToBounds = YES;
    timeCountLabel.text = [NSString stringWithFormat:@"%ld",sTimeCount];
    [self addSubview:timeCountLabel];
    
    messageShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, WIDTH - 60, 0)];
    messageShowLabel.numberOfLines = 0;
    messageShowLabel.textAlignment = NSTextAlignmentCenter;
    messageShowLabel.font = [UIFont systemFontOfSize:17];
    messageShowLabel.text = sMessage.length==0? @"": sMessage;
    [self addSubview:messageShowLabel];
    [messageShowLabel sizeToFit];
}

//添加计时器并且启动
- (void)stratTimeCount
{
    __weak FeatureView *weakSelf = self;
    
    countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(timeChangeAction:) userInfo:nil repeats:YES];
}

//计时器调用方法
- (void)timeChangeAction:(NSTimer *)timer
{
    sTimeCount--;
    if (sTimeCount == -1)
    {
        //计时到0 消失
        [self featureHide];
    }
    
    if (sTimeCount >= 0)
    {
        timeCountLabel.text = [NSString stringWithFormat:@"%ld",sTimeCount];
    }
}

- (void)featureShow
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (![keyWindow.subviews containsObject:self])
    {
        self.frame = keyWindow.bounds;
        [keyWindow addSubview:self];
        
        //开启倒计时器
        [self stratTimeCount];
    }
}

- (void)featureHide
{
    //停止计时器
    [countTimer invalidate];
    countTimer = nil;
    
    //移除视图
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
