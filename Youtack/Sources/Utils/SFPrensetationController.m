//
//  SFPrensetationController.m
//  SFKit
//
//  Created by Yarik Smirnov on 17/11/14.
//  Copyright (c) 2014 SFCD, LLC. All rights reserved.
//

#import "SFPrensetationController.h"
#import <PureLayout/PureLayout.h>

@interface SFPrensetationController ()
@property (nonatomic, strong) UIView *chrome;
@end

@implementation SFPrensetationController

- (UIView *)chrome
{
    if (!_chrome) {
        _chrome = [[UIView alloc] initWithFrame:CGRectZero];
        _chrome.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        [self.containerView addSubview:_chrome];
        [_chrome autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    return _chrome;
    
}

- (void)presentationTransitionWillBegin
{
    self.chrome.alpha = 0;
    
    id<UIViewControllerTransitionCoordinator> cordinator = self.presentingViewController.transitionCoordinator;
    
    [cordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.chrome.alpha = 1;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> cordinator = self.presentingViewController.transitionCoordinator;
    
    [cordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.chrome.alpha = 0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if (![context isCancelled]) {
            [self.chrome removeFromSuperview];
        } else {
            self.chrome.alpha = 1;
        }
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
}


@end
