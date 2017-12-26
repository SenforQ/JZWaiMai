//
//  JZinfoView.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/23.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZinfoView.h"
#import "JZinfoModel.h"

@interface JZinfoView()

@property(nonatomic, strong)UIImageView* iconView;
@property(nonatomic, strong)UILabel* infoLabel;


@end

@implementation JZinfoView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupUI];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self ) {
        [self setupUI];
    }
    
    return self ;
    
}

-(void)setupUI{
    
    //1,头像
    UIImageView* iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(iconView.mas_height).offset(0);
    }];
    
    //2,优惠信息
    UILabel* infoLabel = [[UILabel alloc]init];
    infoLabel.font =  [UIFont systemFontOfSize:12];
    
    infoLabel.textColor = [UIColor blackColor];
    [self addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(10);
        make.centerY.offset(0);
    }];
    
    _iconView = iconView;
    _infoLabel = infoLabel;
    
}

-(void)setInfoModel:(JZinfoModel *)infoModel{
    _infoModel = infoModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:infoModel.icon_url]];
    _infoLabel.text =  infoModel.info;
}


@end
