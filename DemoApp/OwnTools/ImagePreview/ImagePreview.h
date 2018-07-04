//
//  ImagePreview.h
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/3.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePreview : UIView

/* 实例方法
 ** react: 展示的起始位置和大小
 */
- (id)initWithReact:(CGRect)aReact;

/* 展示
 ** nameStr: 图像名字
 */
- (void)showWithImageName:(NSString *)nameStr;

//移除
- (void)remove;

@end
