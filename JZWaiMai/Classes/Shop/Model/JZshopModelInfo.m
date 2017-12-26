//
//  JZshopModelInfo.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZshopModelInfo.h"
#import "JZshopDiscount.h"
@implementation JZshopModelInfo

+(instancetype)shopModelWithDict:(NSDictionary*)dict{
    
    id obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
    
}
//重写此方法可以解决字典key比模型属性多的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //因为Food.json中的在poi_info中有discounts2的数组， 但是由于使用了setValuesForKeysWithDictionary不想取discount方法就是在这里提取数组；
    NSMutableArray* arrM = [[NSMutableArray alloc]init];
    if ([key isEqualToString:@"discounts2"]) {
        for (NSDictionary* dict in value) {
            JZshopDiscount* sD = [JZshopDiscount shopDiscountWithDict:dict];
            [arrM addObject:sD];
        }
        _discounts = arrM;
    }
    
}

@end
