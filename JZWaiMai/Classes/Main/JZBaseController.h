//
//  JZBaseController.h
//  JZWaiMai
//
//  Created by Senfor on 2017/12/11.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZNavigationBar.h"
@interface JZBaseController : UIViewController


@property (nonatomic, strong, readonly)UINavigationItem* navItem;
@property (nonatomic, strong, readonly)JZNavigationBar* navBar;
@property(assign, nonatomic) UIStatusBarStyle statusBarStyle;

@end
