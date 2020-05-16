//
//  UIViewController+Theme.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIViewController+Theme.h"

@implementation UIViewController (Theme)

- (void)setAppearance {
    self.view.backgroundColor = UIColor.whiteColor;
    
    void (^setupNavBar)(UINavigationController*) = ^(UINavigationController *nav) {
        nav.navigationBar.barStyle = UIBarStyleBlack;
        nav.navigationBar.barTintColor = [UIColor colorWithRed:61.0/255.0 green:150.0/255.0 blue:225.0/255.0 alpha:1.0];
        nav.navigationBar.tintColor = UIColor.whiteColor;
        [nav.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [nav.navigationBar setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:19 weight:UIFontWeightSemibold]
        }];
        [nav.interactivePopGestureRecognizer setEnabled:false];
    };
    
    setupNavBar(self.navigationController);
}

@end
