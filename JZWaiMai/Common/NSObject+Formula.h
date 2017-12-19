//
//  NSObject+Formula.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/20.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <Foundation/Foundation.h>
struct JZValue {
    CGFloat consult;
    CGFloat result;
};
typedef struct JZValue JZValue;

CG_INLINE JZValue
JZValueMake(CGFloat consult, CGFloat result)
{
    JZValue value; value.consult = consult; value.result = result; return value;
}

@interface NSObject (Formula)

- (CGFloat)calcResultWithValue1:(JZValue)value1 andValue2:(JZValue)value2;
@end
