//
//  JZshopModelInfo.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZshopModelInfo : NSObject

@property(nonatomic, strong)NSString*  poi_back_pic_url;

+(instancetype)shopModelWithDict:(NSDictionary*)dict;
@end
