//
//  JZHeaderView.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/19.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZHeaderView.h"
#import "UIImage+JZDashLine.h"
#import "JZshopModelInfo.h"
#import "JZinfoLoopView.h"
#import "JZinfoModel.h"
#import "UIView+JZAddition.h"
#import "JZinfoLoopView.h"
#import "JZShopDetailController.h"
#import "JZShopDetailAnimator.h"
@interface JZHeaderView()
@property (nonatomic, strong)UIImageView* backImageView;
@property (nonatomic, strong)UIImageView* iconView;
@property (nonatomic, strong)UILabel* shopNameView;
@property (nonatomic, strong)JZinfoLoopView* loopView;
// 转场动画的代理对象，不能让他提前释放。
@property (nonatomic, strong)JZShopDetailAnimator* animator;
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
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    _backImageView = backImageView;
    
    
    //2，添加轮播器
    
    JZinfoLoopView* loopView = [[JZinfoLoopView alloc]init];
//    loopView.backgroundColor = [UIColor whiteColor];
    _loopView = loopView;
    [self addSubview:loopView];
    [loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-10);
        make.height.offset(20);
    }];
    //给轮播器添加手势；
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loopViewClick)];
    [loopView addGestureRecognizer:tap];
    UIImageView* arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow_white"]];
    [loopView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.offset(0);
    }];
    
    //3，添加虚线
    UIView* lineView = [[UIView alloc]init];
//    lineView.backgroundColor = [UIColor blueColor];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashImageWithColor:[UIColor whiteColor]]];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loopView).offset(0);
        make.right.equalTo(loopView).offset(0);
        make.bottom.equalTo(loopView.mas_top).offset(-10);
        make.height.offset(1);
    }];
    
    //4，添加头像
    UIImageView* iconView = [[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor blackColor];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 20;
    iconView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    iconView.layer.borderWidth = 2;
    _iconView = iconView;
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.bottom.equalTo(lineView.mas_top).offset(-15);
        make.height.width.offset(40);
    }];
    
    //5，添加店名
    UILabel* shopNameView = [[UILabel alloc]init];
    shopNameView.text = @"良心发现";
    shopNameView.font  = [UIFont systemFontOfSize:14];
    shopNameView.textColor = [UIColor blackColor];
    _shopNameView = shopNameView;
    [self addSubview:shopNameView];
    [shopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(15);
        make.width.offset(200);
        make.height.offset(20);
        make.bottom.equalTo(iconView.mas_bottom).offset(-10);
    }];
    
}
//轮播器跳转
-(void)loopViewClick{

    //创建商家详情视图
    JZShopDetailController* shopDetailC = [[JZShopDetailController alloc]init];
    //给商家详情控制器传递数据
    shopDetailC.shopModelInfo = _shopModelInfo;
    //创建转场动画。
    JZShopDetailAnimator* animator = [[JZShopDetailAnimator alloc]init];
    _animator = animator;
    //给商家详情控制器设置转场代理
    shopDetailC.transitioningDelegate = animator;
    //设置跳转动画的效果。 为自定义；
    shopDetailC.modalTransitionStyle = UIModalPresentationCustom;
    //模态出商家详情控制器
    [self.viewController presentViewController:shopDetailC animated:YES completion:nil];
    
}
//添加模型修改数据
-(void)setShopModelInfo:(JZshopModelInfo *)shopModelInfo{
    
    _shopModelInfo = shopModelInfo;
    //设置背景图片;
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:[shopModelInfo.poi_back_pic_url stringByDeletingPathExtension]]];
    //设置头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[shopModelInfo.pic_url stringByDeletingPathExtension]]];
    //设置店名
    _shopNameView.text = [NSString stringWithFormat:@"%@",shopModelInfo.name];
    //设置轮播数据
    //先从大模型中取到一条数据
//    JZshopDiscount* shopDiscount = shopModelInfo.discounts[0];
//    JZinfoModel* infoModel = [[JZinfoModel alloc]init];
//    infoModel.icon_url = shopDiscount.icon_url;
//    infoModel.info = shopDiscount.info;
//    _loopView.infoModel = infoModel;
    
    NSMutableArray* infoModelArray = [NSMutableArray arrayWithCapacity:shopModelInfo.discounts.count];
    for (JZshopDiscount* shopDiscount in shopModelInfo.discounts) {
            JZinfoModel* infoModel = [[JZinfoModel alloc]init];
            infoModel.icon_url = shopDiscount.icon_url;
            infoModel.info = shopDiscount.info;
        [infoModelArray addObject:infoModel];
    }
    _loopView.infoModels = infoModelArray.copy;
    
}

@end
