//
//  JZShopDetailController.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/24.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZShopDetailController.h"
#import "JZshopModelInfo.h"
#import "UILabel+JZAddition.h"
#import "UIView+JZAddition.h"
#import "JZinfoModel.h"
#import "JZinfoView.h"
#import "JZshopDiscount.h"
@interface JZScrollView : UIScrollView
@end
@implementation JZScrollView

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
@interface JZShopDetailController ()
@property (nonatomic, strong)UIImageView* backgroundImageview;
@property (nonatomic, strong)UIView* detailView;
@end

@implementation JZShopDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
//    添加背景图片
    UIImageView* backgroundImageview = [[UIImageView alloc]init];
    [backgroundImageview sd_setImageWithURL:[NSURL URLWithString:[_shopModelInfo.poi_back_pic_url stringByDeletingPathExtension]]];
    _backgroundImageview = backgroundImageview;
    //添加背景控件
    [self.view addSubview:_backgroundImageview];
    [_backgroundImageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.right.offset(0);
        make.edges.offset(0);
    }];
    
    
    //TODO:添加返回按钮。
    UIButton* backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"btn_close_selected"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-60);
    }];
    
    //添加ScrollView; JZScrollView中添加toucheEnd。
    JZScrollView* shopDetailScrollView = [[JZScrollView alloc]init];
    shopDetailScrollView.showsVerticalScrollIndicator = NO;
    shopDetailScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:shopDetailScrollView];
    
    [shopDetailScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.equalTo(backBtn.mas_top).offset(-60);
    }];
    
    //在ScrollView上添加UIView，因为UIView是ScrollView直接子控件所以需要明确的宽高;
    UIView* detailView = [[UIView alloc]init];
    [shopDetailScrollView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.width.equalTo(shopDetailScrollView.mas_width).offset(0);
//        make.height.offset(1000);
    }];
    _detailView = detailView;
    
//#warning 所有的信息添加到detailView；
    //店名
    UILabel* shopName = [UILabel makeLabelWithText:_shopModelInfo.name andTextFont:[UIFont systemFontOfSize:14] andTextColor:[UIColor whiteColor]];
    [detailView addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(64);
    }];
    //起送及配送价
    UILabel* detailTipLabel = [[UILabel alloc]init];
    detailTipLabel.font = [UIFont systemFontOfSize:12];
    detailTipLabel.textColor = [UIColor colorWithWhite:1 alpha:0.9];
    [detailView addSubview:detailTipLabel];
    detailTipLabel.text = [NSString stringWithFormat:@"%@  |  %@|  %@",_shopModelInfo.min_price_tip, _shopModelInfo.shipping_fee_tip,_shopModelInfo.delivery_time_tip];
    [detailTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(shopName.mas_bottom).offset(16);
    }];
    //-折扣信息-
    UILabel* discountLabel = [UILabel makeLabelWithText:@"折扣信息" andTextFont:[UIFont systemFontOfSize:16] andTextColor:[UIColor whiteColor]];
    [detailView addSubview:discountLabel];
    [discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(detailTipLabel.mas_bottom).offset(40);
    }];
//    折扣信息的两边横线
    UIView* discountLineLeft = [[UIView alloc]init];
    discountLineLeft.backgroundColor = [UIColor whiteColor];
    [detailView addSubview:discountLineLeft];
    [discountLineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.offset(16);
        make.right.equalTo(discountLabel.mas_left).offset(-16);
        make.centerY.equalTo(discountLabel).offset(0);
    }];
    
    UIView* discountLineRight = [[UIView alloc]init];
    discountLineRight.backgroundColor = [UIColor whiteColor];
    [detailView addSubview:discountLineRight];
    [discountLineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.right.offset(-16);
        make.left.equalTo(discountLabel.mas_right).offset(16);
        make.centerY.equalTo(discountLabel).offset(0);
    }];
    
    //优惠信息。
    UIStackView* discountStackView = [[UIStackView alloc]init];
    
    //轴向,垂直
    discountStackView.axis = UILayoutConstraintAxisVertical;
    //分布
    discountStackView.distribution  =UIStackViewDistributionFillEqually;
    //间距
    discountStackView.spacing = 10;
    
    for (JZshopDiscount* discountDict in _shopModelInfo.discounts) {
        //创建infoView视图
        JZinfoView* infoView = [[JZinfoView alloc]init];
        //创建infoModel模型
        JZinfoModel* detaModel = [[JZinfoModel alloc]init];
        detaModel.icon_url = discountDict.icon_url;
        detaModel.info = discountDict.info;
        infoView.infoModel = detaModel;
        //给优惠信息添加信息。
        [discountStackView addArrangedSubview:infoView];
    }
    
    [detailView addSubview:discountStackView];
    
    [discountStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(discountLabel.mas_bottom).offset(16);
        make.height.offset(_shopModelInfo.discounts.count * 30);
    }];
    
    
    //-公告信息-
    UILabel* bulletinLabel = [UILabel makeLabelWithText:@"公告信息" andTextFont:[UIFont systemFontOfSize:16] andTextColor:[UIColor whiteColor]];
    [detailView addSubview:bulletinLabel];
    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(discountStackView.mas_bottom).offset(40);
    }];
    // 公告信息的两边横线
    UIView* bulletinLabelLineLeft = [[UIView alloc]init];
    bulletinLabelLineLeft.backgroundColor = [UIColor whiteColor];
    [detailView addSubview:bulletinLabelLineLeft];
    [bulletinLabelLineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.offset(16);
        make.right.equalTo(bulletinLabel.mas_left).offset(-16);
        make.centerY.equalTo(bulletinLabel).offset(0);
    }];
    
    UIView* bulletinLabelLineRight = [[UIView alloc]init];
    bulletinLabelLineRight.backgroundColor = [UIColor whiteColor];
    [detailView addSubview:bulletinLabelLineRight];
    [bulletinLabelLineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.right.offset(-16);
        make.left.equalTo(bulletinLabel.mas_right).offset(16);
        make.centerY.equalTo(bulletinLabel).offset(0);
    }];
    //公告的详细信息；
    UILabel* bulletinInfoLabel = [UILabel makeLabelWithText:_shopModelInfo.bulletin andTextFont:[UIFont systemFontOfSize:12] andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
//    自动换行
    bulletinInfoLabel.numberOfLines = 0;
    [detailView addSubview:bulletinInfoLabel];
    [bulletinInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.equalTo(bulletinLabel.mas_bottom).offset(16);
//        自动计算detailView的高度。
        make.bottom.offset(-16);
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)backBtnClick:(UIButton*)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
