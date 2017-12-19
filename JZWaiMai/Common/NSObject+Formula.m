//
//  NSObject+Formula.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/20.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "NSObject+Formula.h"

@implementation NSObject (Formula)


- (CGFloat)calcResultWithValue1:(JZValue)value1 andValue2:(JZValue)value2{
    
    CGFloat consult = [(id)self floatValue];
    
    // y = a * x + b
    // result1 = a * consult1 + b
    // result2 = a * consult2 + b
    
    // (result1 - result2) = (consult1 - consult2) * a
    CGFloat a = (value1.result - value2.result) / (value1.consult - value2.consult);
    // result1 = (result1 - result2) / (consult1 - consult2) * consult1 + b
    CGFloat b = value1.result - (a * value1.consult);
    
    return a * consult + b;
    
}


@end
