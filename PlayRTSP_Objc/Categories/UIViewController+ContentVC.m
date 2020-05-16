//
//  UIViewController+ContentVC.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIViewController+ContentVC.h"

@implementation UIViewController (ContentVC)

- (UIViewController*)contentViewController {
    if ([self isKindOfClass:[UITabBarController class]]) {
        return ((UITabBarController*)self).selectedViewController.contentViewController;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController*)self).visibleViewController.contentViewController;
    } else if (self.presentedViewController) {
        return self.presentedViewController.contentViewController;
    }
    return self;
}

@end

@implementation UIApplication (ContentVC)

- (UIWindow*)mainWindow {
    NSPredicate *isKeyWindow = [NSPredicate predicateWithFormat:@"isKeyWindow == YES"];
    return [[[UIApplication sharedApplication] windows] filteredArrayUsingPredicate:isKeyWindow].firstObject;
}

- (UIViewController*)contentViewController {
    return self.mainWindow.rootViewController.contentViewController;
}

@end
