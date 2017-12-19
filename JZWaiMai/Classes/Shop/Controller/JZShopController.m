//
//  JZShopController.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/11.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZShopController.h"
#import "JZFoodDetailController.h"
#import "JZShopCommentViewController.h"
#import "JZShopInfoViewController.h"
#import "JZShopOrderController.h"
#import "UIColor+JZAddition.h"
#import "JZshopModelInfo.h"
#import "JZHeaderView.h"

#define KShopHeaderViewMaxH 180 //商店头视图最高
#define KshopHeaderViewMinH 64  //商品头视图最低


@interface JZShopController () <UIScrollViewDelegate>
@property (nonatomic, strong)JZHeaderView* headerView;
@property (nonatomic, weak)UIView* shopTagView;
@property (nonatomic, weak)UIView* yelloStrip;
@property (nonatomic, strong)JZshopModelInfo* shopModelInfo;
@end

@implementation JZShopController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    
    self.navTitle.title = @"123";

    //实现创建头视图方法。
    [self setUI];
    
}

-(void)setUI{
    //创建头视图
    [self settingHeaderView];
    
    // TODO:标签视图
    [self settingTagView];
    
    // TODO:滑动视图
    [self settingScrollView];
    
}
#pragma mark -头视图
-(void)settingHeaderView{
    JZHeaderView* headerView = [[JZHeaderView alloc]init];
    headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:headerView];
    _headerView = headerView;
    _headerView.shopModelInfo = _shopModelInfo;
    //添加约束
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(KShopHeaderViewMaxH);
    }];
    
    //添加shop平移事件
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    [self.view addGestureRecognizer:pan];
    
    //给导航条添加右边按钮
    self.navTitle.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];

}
#pragma mark -标签视图
-(void)settingTagView{
    UIView* shopTagView = [[UIView alloc]init];
    shopTagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopTagView];
    _shopTagView = shopTagView;
    
    [shopTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(44);
        make.top.equalTo(_headerView.mas_bottom).offset(0);
        make.left.right.offset(0);
    }];
    UIButton* orderBtn = [self btnAndWithTitleLabel:@"点菜"];
    orderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self btnAndWithTitleLabel:@"评价"];
    [self btnAndWithTitleLabel:@"商家"];
    
    [shopTagView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    [shopTagView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    //添加小黄条
    UIView* yellowStrip = [[UIView alloc]init];
    yellowStrip.backgroundColor  = [UIColor primaryYellowColor];
    _yelloStrip = yellowStrip;
    [shopTagView addSubview:yellowStrip];
    
    [yellowStrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(4);
        make.width.offset(50);
        make.bottom.offset(0);
        make.centerX.equalTo(orderBtn).offset(0);
    }];
    
}
#pragma mark -标签菜单按钮
-(UIButton*)btnAndWithTitleLabel:(NSString*)labTitle{
    UIButton* btn  = [[UIButton alloc]init];
    [btn setTitle:labTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shopTagView addSubview:btn];
    return btn;
}
#pragma mark -滚动视图
-(void)settingScrollView{
    UIScrollView* shopScoView = [[UIScrollView alloc]init];
    //    shopScoView.backgroundColor = [UIColor grayColor];
    shopScoView.bounces = NO;
    shopScoView.pagingEnabled = YES;
    shopScoView.showsVerticalScrollIndicator = NO;
    shopScoView.showsHorizontalScrollIndicator = NO;
//    _shopScoView = shopScoView;
    [self.view addSubview:shopScoView];
    
    [shopScoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(_shopTagView.mas_bottom).offset(0);
    }];
    
    
    //添加点菜，评价，商家页面；
    JZShopOrderController* shopOrder = [[JZShopOrderController alloc]init];
    JZShopCommentViewController* shopComment = [[JZShopCommentViewController alloc]init];
    JZShopInfoViewController* shopInfo = [[JZShopInfoViewController alloc]init];
    
    NSArray* nav = @[shopOrder,shopComment,shopInfo];
    
    for (UIViewController* vc  in nav) {
        
        [shopScoView addSubview:vc.view];
        //建立父子控制器关系
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        
    }
    
    //设置ScroView中的子控件xy，和高宽
    [shopScoView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.equalTo(shopScoView);
    }];
    // 给子空间添加x/w的约束， 都为0间距。
    [shopScoView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    shopScoView.delegate = self;
    
}
#pragma mark -平移手势的方法
-(void)panGesture:(UIPanGestureRecognizer*)pan{
    
//    获取偏移量
    CGPoint p = [pan translationInView:pan.view];
    //实时更新约束
    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        if(_headerView.bounds.size.height + p.y >= KShopHeaderViewMaxH){
            make.height.offset(KShopHeaderViewMaxH);
        }else if(_headerView.bounds.size.height + p.y <= KshopHeaderViewMinH){
            make.height.offset(KshopHeaderViewMinH);
        }else{
        make.height.offset(p.y + _headerView.bounds.size.height);
        }
    }];
    //让平移量复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算走第小数页
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //每次走的距离
    CGFloat transformOnceX = scrollView.bounds.size.width / scrollView.subviews.count;
    //移动小黄条
    _yelloStrip.transform = CGAffineTransformMakeTranslation(transformOnceX * page, 0);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算走到第几页
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //根据标签视图的子控制器循环
    for (NSInteger i = 0 ; i < _shopTagView.subviews.count ; i++) {
        //因为子控制器中有UIView，所以对此进行判断。
        UIButton* btn = _shopTagView.subviews[i];
        if([btn isKindOfClass:[UIButton class]]) {
            if (i == page) {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            }else{
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
        }
    }
}

#pragma mark - 加载数据
-(void)loadData{
    NSData* data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil]];
    
    NSDictionary* JSONDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary* poi_infoDict = JSONDict[@"data"][@"poi_info"];
    
    JZshopModelInfo* model_info = [JZshopModelInfo shopModelWithDict:poi_infoDict];
    
    _shopModelInfo = model_info;
    
    NSLog(@"%@",model_info.poi_back_pic_url);
}
@end
