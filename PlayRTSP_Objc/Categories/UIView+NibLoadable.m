//
//  UIView+NibLoadable.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIView+NibLoadable.h"

@implementation UIView (NibLoadable)

- (UIView*)fromNib {
    NSString *name = [[NSString stringWithFormat:@"%@", self.class] componentsSeparatedByString:@"."].firstObject;
    UIView *contentView = [[UINib nibWithNibName:name bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    [self addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = false;
    [contentView edgesToView:self];
    return contentView;
}

- (void)edgesToView:(UIView*)view {
    [self edgesToView:view top:0 bottom:0 left:0 right:0];
}

- (void)edgesToView:(UIView*)view
                top:(CGFloat)top
             bottom:(CGFloat)bottom
               left:(CGFloat)left
              right:(CGFloat)right {
    id objects[] = {
        [self.topAnchor constraintEqualToAnchor:view.topAnchor constant:top],
        [self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:bottom],
        [self.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:left],
        [self.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:right]
    };
    NSUInteger count = sizeof(objects) / sizeof(id);
    [NSLayoutConstraint activateConstraints:[NSArray arrayWithObjects:objects count:count]];
}

@end
