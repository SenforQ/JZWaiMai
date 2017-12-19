//
//  JZNavigationBar.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/20.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZNavigationBar.h"

@implementation JZNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.image = [UIImage imageNamed:@"bg_navigationBar_white"];
        [self addSubview:_backgroundView];
        
        // 自动布局 摆放位置
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return self;
}


@end
