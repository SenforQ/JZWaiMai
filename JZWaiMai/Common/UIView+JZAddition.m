//
//  UIView+JZAddition.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/24.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "UIView+JZAddition.h"

@implementation UIView (JZAddition)

-(UIViewController*)viewController{
    //寻找下一位响应者
    UIResponder* resp = [self nextResponder];
    
    while (YES) {
        //判断响应者是否为空
        if (resp == nil) {
            return nil;
        }
        //如果当前响应者为控制器则返回。
        if([resp isKindOfClass:[UIViewController class]]){
            return (UIViewController*)resp;
        }
        //如果不是控制器就继续往下找
        resp = [resp nextResponder];
    }
    return nil;
}

@end
