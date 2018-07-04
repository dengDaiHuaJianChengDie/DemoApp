//
//  ImagePreview.m
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/3.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import "ImagePreview.h"

@implementation ImagePreview
{
    CGRect pReact;//视图展示的其实位置与大小
    
    UIImageView *displayImageView;//图片展示View
}

- (id)initWithReact:(CGRect)aReact
{
    self=[super init];
    
    if (self)
    {
        pReact = aReact;
        
        //添加子视图
        [self addSubViews];
    }
    
    return self;
}

//添加子视图
- (void)addSubViews
{
    if (displayImageView == nil)
    {
        displayImageView = [[UIImageView alloc]init];
        displayImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:displayImageView];
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        displayImageView.userInteractionEnabled = YES;
        [displayImageView addGestureRecognizer:tapGesture];
    }
}

//手势的点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self remove];
}

- (void)showWithImageName:(NSString *)nameStr
{
    self.frame = pReact;
    self->displayImageView.frame = CGRectMake(0, 0, 80, 80);
    self->displayImageView.image = [UIImage imageNamed:nameStr];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (![keyWindow.subviews containsObject:self])
    {
        [keyWindow addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = keyWindow.bounds;
            self->displayImageView.frame = keyWindow.bounds;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)remove
{
    CGRect aFrame = pReact;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = aFrame;
        self->displayImageView.frame = CGRectMake(0, 0, 80, 80);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
