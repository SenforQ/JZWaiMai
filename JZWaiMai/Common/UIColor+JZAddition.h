//
//  UIColor+JZAddition.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JZAddition)

//主题色
+(instancetype)primaryYellowColor;
//转换64位颜色;
+(instancetype)colorWithHex:(uint32_t)hex;
//随机颜色
+(instancetype)randomColor;
//颜色取缔
+(instancetype)colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;
@end
