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
        UINavigationBar* navb = [[UINavigationBar alloc]init];
        _navb = navb;
        
       
        
        UINavigationItem* navTitle = [[UINavigationItem alloc]init];
        [navb setItems:@[navTitle]];
        _navTitle = navTitle;
        
         /** 把导航条的属性及NavTitle的创建及属性值都写在添加导航条到View的前面**/
        
        [self.view addSubview:navb];
        
        [navb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.offset(64);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
}


@end
