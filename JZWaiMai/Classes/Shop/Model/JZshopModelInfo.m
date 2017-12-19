//
//  JZshopModelInfo.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZshopModelInfo.h"

@implementation JZshopModelInfo

+(instancetype)shopModelWithDict:(NSDictionary*)dict{
    
    id obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
    
}
//重写此方法可以解决字典key比模型属性多的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
