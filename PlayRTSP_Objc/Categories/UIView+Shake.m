//
//  UIView+Shake.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIView+Shake.h"

NSString * const kShakeAnimationKey = @"shaking";

@implementation UIView (Shake)

- (void)startShaking {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.duration = 0.05;
    shakeAnimation.repeatCount = 2;
    shakeAnimation.autoreverses = true;
    
    float startAngle = 2 * M_PI / 180;
    float stopAngle = -startAngle;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:2 * startAngle];
    shakeAnimation.toValue = [NSNumber numberWithFloat:2 * stopAngle];
    shakeAnimation.duration = 0.12;
    shakeAnimation.repeatCount = 10000;
    shakeAnimation.autoreverses = true;
    shakeAnimation.timeOffset = 290 * drand48();
    
    [self.layer addAnimation:shakeAnimation forKey:kShakeAnimationKey];
}

- (void)stopShaking {
    [self.layer removeAnimationForKey:kShakeAnimationKey];
}

@end
