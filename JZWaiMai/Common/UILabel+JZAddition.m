//
//  UILabel+JZAddition.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/24.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "UILabel+JZAddition.h"

@implementation UILabel (JZAddition)

+(instancetype)makeLabelWithText:(NSString *)label andTextFont:(UIFont *)font andTextColor:(UIColor *)color{
    UILabel* tempLabel = [[UILabel alloc]init];
    tempLabel.text = label;
    tempLabel.textColor = color;
    tempLabel.font = font;
    return tempLabel;
}

@end
