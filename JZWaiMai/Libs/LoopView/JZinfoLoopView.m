//
//  JZinfoLoopView.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/21.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZinfoLoopView.h"
#import "JZinfoView.h"
@interface JZinfoLoopView()

@property(nonatomic, weak)JZinfoView* infoView1;
@property(nonatomic, weak)JZinfoView* infoView2;
@property(nonatomic, assign)NSInteger currentIndex;
@end
@implementation JZinfoLoopView

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
    //创建两个infoView 实现数据传递以及滑动；
    JZinfoView* infoView1 = [[JZinfoView alloc]init];
    [self addSubview:infoView1];
    [infoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.offset(-16);
    }];
    
    JZinfoView* infoView2 = [[JZinfoView alloc]init];
    [self addSubview:infoView2];
    [infoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView1.mas_bottom).offset(0);
        make.width.left.height.equalTo(infoView1).offset(0);
    }];
    
//    infoView需要滑动。需要数据。然后我们的infoView里面有infoModel；所以我们需要在这个loopView创建一个模型传入值。
    _infoView1 = infoView1;
    _infoView2 = infoView2;
    
    self.clipsToBounds = YES;  //裁剪多余的部分.
}

-(void)setInfoModels:(NSArray<JZinfoModel *> *)infoModels{
    _infoModels = infoModels;
//    给info传值
    [self setupInfo];
    
//    平移infoView;
    [self scrollInfoView];
}

-(void)setupInfo{
    if (_currentIndex + 1 == _infoModels.count) {
        _infoView1.infoModel = _infoModels[_currentIndex];
        _infoView2.infoModel = _infoModels[0];
        //索引归位
        _currentIndex = -1;
    }else{
    //正常页面 非最后一页
    _infoView1.infoModel = _infoModels[_currentIndex];
    _infoView2.infoModel = _infoModels[_currentIndex + 1];
    }
}

-(void)scrollInfoView{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
//            让两个一起平移上去
            _infoView1.transform = CGAffineTransformMakeTranslation(0, - self.bounds.size.height);
            _infoView2.transform = CGAffineTransformMakeTranslation(0, - self.bounds.size.height);
        } completion:^(BOOL finished) {
            
//            索引
            _currentIndex++;
//            更新数据
            [self setupInfo];
//            归位
            _infoView1.transform = CGAffineTransformIdentity;
            _infoView2.transform = CGAffineTransformIdentity;
//            自滚 防止数组越界。
            [self scrollInfoView];
        }];
    });
    
}
@end
