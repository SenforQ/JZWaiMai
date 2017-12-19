//
//  JZBaseController.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/11.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZBaseController.h"

@interface JZBaseController ()

@end

@implementation JZBaseController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        UINavigationBar* navb = [[UINavigationBar alloc]init];
//        _navBar = navb;
//        
//       
//        
//        UINavigationItem* navTitle = [[UINavigationItem alloc]init];
//        [navb setItems:@[navTitle]];
//        _navTitle = navTitle;
//        
//         /** 把导航条的属性及NavTitle的创建及属性值都写在添加导航条到View的前面**/
//        
//        [self.view addSubview:navb];
//        
//        [navb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.offset(0);
//            make.height.offset(64);
//        }];
        // 在调用这个控制器的view之前(在viewDidLoad中设置相关内容之前)去创建navItem
        _navItem = [[UINavigationItem alloc] init];
        
        _navBar = [[JZNavigationBar alloc] init];
    }
    return self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:_navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    // 设置导航条的背景图片
    [_navBar setShadowImage:[UIImage new]];
    [_navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [_navBar setItems:@[_navItem]];
    [self.view addSubview:_navBar];
    
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(64);
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    // 更新当前传进来的状态栏样式
    [self setNeedsStatusBarAppearanceUpdate];
}


@end
