//
//  HomeImageShowCell.h
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/4.
//  Copyright © 2018年 魏佃文. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol HomeImageShowCellDelegate <NSObject>

@required
- (void)didClickOneImageWithTag:(NSInteger)aTag andIndex:(NSIndexPath *)indexP andImageView:(UIImageView *)image;

@end

@interface HomeImageShowCell : UITableViewCell

//代理属性
@property (assign,nonatomic) id<HomeImageShowCellDelegate> delegate;

//cell的位置
@property (strong,nonatomic) NSIndexPath *cellIndexPath;

//传入数据配置页面
- (void)congigueUIWithData:(NSMutableArray *)imagesArr;

@end
