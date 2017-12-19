//
//  JZHeaderView.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZHeaderView.h"

#import "JZshopModelInfo.h"
@interface JZHeaderView()
@property (nonatomic, strong)UIImageView* backImageView;
@end

@implementation JZHeaderView
//防止数据读不出来
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setupUI];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
    
}

-(void)setupUI{
    //1.背景图片
    UIImageView* backImageView = [[UIImageView alloc]init];
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    _backImageView = backImageView;
    
    
    //2，添加轮播器
    
    UIView* looperView = [[UIView alloc]init];
    looperView.backgroundColor = [UIColor whiteColor];
    [self addSubview:looperView];
    [looperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-10);
        make.height.offset(20);
    }];
    
    
    //3，添加虚线
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blueColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(looperView).offset(0);
        make.right.equalTo(looperView).offset(0);
        make.bottom.equalTo(looperView.mas_top).offset(-10);
        make.height.offset(1);
    }];
    
    //4，添加头像
    UIImageView* iconView = [[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor blackColor];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.bottom.equalTo(lineView.mas_top).offset(-15);
        make.height.width.offset(40);
    }];
    
    //5，添加店名
    UIView* shopNameView = [[UIView alloc]init];
    shopNameView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shopNameView];
    [shopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(15);
        make.width.offset(200);
        make.height.offset(20);
        make.bottom.equalTo(iconView.mas_bottom).offset(-10);
    }];
}

-(void)setShopModelInfo:(JZshopModelInfo *)shopModelInfo{
    _shopModelInfo = shopModelInfo;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:[shopModelInfo.poi_back_pic_url stringByDeletingPathExtension]]];
}

@end
