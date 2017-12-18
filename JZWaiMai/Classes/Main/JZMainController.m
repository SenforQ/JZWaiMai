//
//  JZMainController.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/11.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZMainController.h"
#import "JZBaseController.h"
@interface JZMainController ()

@end

@implementation JZMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden  = YES;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:YES];
    
    if (self.childViewControllers.count > 1) {
        ((JZBaseController*)viewController).navTitle.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
