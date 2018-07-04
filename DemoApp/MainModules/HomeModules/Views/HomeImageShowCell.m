//
//  HomeImageShowCell.m
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/4.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import "HomeImageShowCell.h"

@implementation HomeImageShowCell
{
    UIImageView *firstImageView;
    UIImageView *secondImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//此方法可以按照需求改成加载远程图像的方法
- (void)congigueUIWithData:(NSMutableArray *)imagesArr
{
    if (firstImageView == nil)
    {
        firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 80, 80)];
        firstImageView.tag = 100;
        firstImageView.contentMode = UIViewContentModeScaleAspectFill;
        firstImageView.clipsToBounds = YES;
        firstImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:firstImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [firstImageView addGestureRecognizer:tapGesture];
    }
    else
    {
        //如果已经存在 改为默认图
        firstImageView.image = [UIImage imageNamed:@""];
    }
    
    if (secondImageView == nil)
    {
        secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-30-80, 10, 80, 80)];
        secondImageView.tag = 101;
        secondImageView.contentMode = UIViewContentModeScaleAspectFill;
        secondImageView.clipsToBounds = YES;
        secondImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:secondImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [secondImageView addGestureRecognizer:tapGesture];
    }
    else
    {
        //如果已经存在 改为默认图
        secondImageView.image = [UIImage imageNamed:@""];
    }
    secondImageView.hidden = YES;
    
    //添加展示视图
    NSString *firstImageName = imagesArr[0];
    firstImageView.image = [UIImage imageNamed:firstImageName];
    [self drawCornerRadiusWithImage:firstImageView];
    
    if (imagesArr.count > 1)
    {
        secondImageView.hidden = NO;
        NSString *secondImageName = imagesArr[1];
        secondImageView.image = [UIImage imageNamed:secondImageName];
        [self drawCornerRadiusWithImage:secondImageView];
    }
}

//绘制圆角
- (void)drawCornerRadiusWithImage:(UIImageView *)imageView
{
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:imageView.frame.size.width] addClip];
    [imageView drawRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
}

//手势的点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView =(UIImageView *)tap.view;

    [_delegate didClickOneImageWithTag:imageView.tag andIndex:_cellIndexPath andImageView:imageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
