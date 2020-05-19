//
//  UICollectionViewCell+Bouncible.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/19/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UICollectionViewCell+Bouncible.h"

static const CGFloat kHighlightedFactor = 0.96;

@implementation UICollectionViewCell (Bouncible)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self animate:YES completion:nil];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self animate:NO completion:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self animate:NO completion:nil];
}

- (void)animate:(BOOL)isHighlighted completion:(void (^)(BOOL))completion {
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        if (isHighlighted) {
            self.transform = CGAffineTransformScale(self.transform, kHighlightedFactor, kHighlightedFactor);
        } else {
            self.transform = CGAffineTransformIdentity;
        }
    }
                     completion:completion];
}

@end
