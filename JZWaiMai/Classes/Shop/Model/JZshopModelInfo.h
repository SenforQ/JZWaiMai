//
//  JZshopModelInfo.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZshopDiscount.h"
@interface JZshopModelInfo : NSObject

//头视图背景
@property(nonatomic, strong)NSString*  poi_back_pic_url;
//店的图片
@property(nonatomic, strong)NSString*  pic_url;
//店名
@property(nonatomic, strong)NSString* name;
//优惠信息
@property(nonatomic, strong)NSArray<JZshopDiscount*>* discounts;
//起送价
@property(nonatomic, strong)NSString* min_price_tip;
//配送费
@property(nonatomic, strong)NSString* shipping_fee_tip;
//配送时间
@property(nonatomic, strong)NSString* delivery_time_tip;
//商家公告
@property(nonatomic, strong)NSString* bulletin;
+(instancetype)shopModelWithDict:(NSDictionary*)dict;
@end
