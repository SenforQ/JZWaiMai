//
//  UIImage+JZDashLine.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/20.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "UIImage+JZDashLine.h"

@implementation UIImage (JZDashLine)

+(instancetype)dashImageWithColor:(UIColor*)color{
    //1.开启图片类型上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(4, 1), NO, 0);
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.画线
    CGContextMoveToPoint(ctx, 0, 1);
    CGContextAddLineToPoint(ctx, 4, 1);
    //4.设置虚线
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    //5.设置线的颜色
    [color set];
    //6.渲染
    CGContextStrokePath(ctx);
    //7.获取图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    //8.关闭图片类型上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
