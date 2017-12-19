//
//  JZFoodDetailController.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/11.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZFoodDetailController.h"


@interface JZFoodDetailController ()

@end

@implementation JZFoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.navBar.backgroundColor = [UIColor lightGrayColor];
    self.navItem.title = @"红烧肉";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
