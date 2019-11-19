//
//  NavigationViewController.m
//  CubeLive
//
//  Created by Chancc on 2019/11/4.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

/* 效果等同于设置 UINavigationBar 的tintColor属性 同时会默认设置translucent为false */
@property (strong, nonatomic) UIColor *navigationBarTintColor;

@end

@implementation NavigationViewController

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    _navigationBarTintColor = navigationBarTintColor;
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = navigationBarTintColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarTintColor = kColorWithHex(0xFFA07A);
    
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置右滑返回手势的代理为自身
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" image:@"back.png" Target:viewController.navigationController Action:@selector(popViewControllerAnimated:)];
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0]) {
            return NO;
        }
    }
    return YES;
}

@end
