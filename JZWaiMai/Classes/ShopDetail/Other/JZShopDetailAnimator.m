//
//  JZShopDetailAnimator.m
//  JZWaiMai
//
//  Created by Senfor on 2017/12/26.
//  Copyright © 2017年 Senfor. All rights reserved.
//

#import "JZShopDetailAnimator.h"
typedef enum : NSUInteger{
    UIViewControllerAnimatedTransitioningPresent,
    UIViewControllerAnimatedTransitioningDismiss
} UIViewControllerAnimatedTransitioningType;
@interface JZShopDetailAnimator()<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)UIViewControllerAnimatedTransitioningType type;

@end
@implementation JZShopDetailAnimator
//下面两个方法为UIViewControllerTransitioningDelegate协议方法
//当腰PResent时就会调用此方法‘modal‘时调用此方法；
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    _type =UIViewControllerAnimatedTransitioningPresent;
    
    return self;
}
//当dismiss时会调用
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    _type =UIViewControllerAnimatedTransitioningDismiss;
    
    return self;
}

//下面两个方法为UIViewControllerAnimatedTransitioning必须遵守协议方法
//动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}
// 自定义modal和dismiss方法；
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    如果当前时persent时，toView就是要现实要modal的控制器view
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    if (_type == UIViewControllerAnimatedTransitioningPresent) {
        //    获取转场容器视图
        UIView* containerView = [transitionContext containerView];
//        把药现实的view添加到容器视图中
        [containerView addSubview:toView];
//        一开始缩放到最小
        toView.transform = CGAffineTransformMakeScale(0, 0);
            [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                //    告诉系统转场完成，可以交互 如果少了这句完成将无法完成交互
                [transitionContext completeTransition:YES];
            }];
    }else{
        
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
//            填写0将会取消动画效果。
            fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            //    告诉系统转场完成，可以交互 如果少了这句完成将无法完成交互
            [transitionContext completeTransition:YES];
        }];
        
    }
    
}

@end
