//
//  SCRSearchResultsAnimatedTransition.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultsAnimatedTransition.h"

CGFloat const kSCRSearchResultsAnimatedTransitionTopInset = 64.0f;

@implementation SCRSearchResultsAnimatedTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    CGFloat toViewHeight = [UIScreen mainScreen].bounds.size.height - kSCRSearchResultsAnimatedTransitionTopInset;
    
    if (self.isPresenting) {
        
        toView.frame = CGRectMake(fromView.frame.origin.x, fromView.frame.size.height - toViewHeight, fromView.frame.size.width, toViewHeight);
        toView.transform = CGAffineTransformMakeTranslation(0.0f, toViewHeight);
        fromView.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:
         ^{
             fromView.alpha = 0.5f;
             fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
             toView.transform = CGAffineTransformIdentity;
             
         } completion:
         ^(BOOL finished) {
             [transitionContext completeTransition:finished];
         }];
    } else {
        
        toView.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            toView.alpha = 1.0f;
            fromView.transform = CGAffineTransformMakeTranslation(0.0f, toViewHeight);;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }
}

@end
