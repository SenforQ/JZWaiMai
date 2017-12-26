//
//  JZshopDiscount.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/21.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZshopDiscount : NSObject
//图片
@property (nonatomic, strong)NSString* icon_url;
//信息
@property (nonatomic, strong)NSString* info;

+(instancetype)shopDiscountWithDict:(NSDictionary*)dict;
@end
