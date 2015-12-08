//
//  CalenderAnimationController.m
//  calenderAnimator
//
//  Created by annidyfeng on 15/12/8.
//  Copyright © 2015年 annidyfeng. All rights reserved.
//

#import "CalenderAnimationController.h"

@implementation CalenderAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    if(self.reverse){
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

- (void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromView];
    fromView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];
    
    CGRect upRegion = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height/2);
    UIView *upView = [fromView resizableSnapshotViewFromRect:upRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    upView.frame = upRegion;
    [containerView addSubview:upView];
    
    CGRect downRegion = CGRectMake(0, fromView.frame.size.height/2, fromView.frame.size.width, fromView.frame.size.height/2);
    UIView *downView = [fromView resizableSnapshotViewFromRect:downRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    downView.frame = downRegion;
    [containerView addSubview:downView];
    
    toView.frame = CGRectOffset(toView.frame, 0, toView.frame.size.height/2);

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         upView.frame = CGRectOffset(upView.frame, 0, -upView.frame.size.height);
                         downView.frame = CGRectOffset(downView.frame, 0, downView.frame.size.height);

                         toView.frame = CGRectOffset(toView.frame, 0, -toView.frame.size.height/2);
                     }
                     completion:^(BOOL finished) {
                         [upView removeFromSuperview];
                         [downView removeFromSuperview];
                         fromView.frame = containerView.frame;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromView];
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];
    
    CGRect upRegion = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height/2);
    UIView *upView = [toView resizableSnapshotViewFromRect:upRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    upView.frame = CGRectOffset(upRegion, 0, -upView.frame.size.height);
    [containerView addSubview:upView];
    
    CGRect downRegion = CGRectMake(0, toView.frame.size.height/2, toView.frame.size.width, toView.frame.size.height/2);
    UIView *downView = [toView resizableSnapshotViewFromRect:downRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    downView.frame = CGRectOffset(downRegion, 0, downView.frame.size.height);;
    [containerView addSubview:downView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         upView.frame = upRegion;
                         downView.frame = downRegion;
                         
                         fromView.frame = CGRectOffset(fromView.frame, 0, fromView.frame.size.height/2);
                     }
                     completion:^(BOOL finished) {
                         // remove all the temporary views
                         [upView removeFromSuperview];
                         [downView removeFromSuperview];
                         toView.frame = containerView.frame;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
