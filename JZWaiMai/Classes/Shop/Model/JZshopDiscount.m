//
//  JZshopDiscount.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/21.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZshopDiscount.h"
//读取discounts2上的数据
@implementation JZshopDiscount

+(instancetype)shopDiscountWithDict:(NSDictionary*)dict{
    id obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
