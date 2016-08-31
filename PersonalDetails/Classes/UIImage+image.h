//
//  UIImage+image.h
//  PersonalDetails
//
//  Created by hanvon on 16/8/30.
//  Copyright © 2016年 hanvon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
