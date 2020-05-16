//
//  XButton.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "XButton.h"

@interface XButton ()

@property (nonatomic, readonly) NSString *message;

@end

@implementation XButton

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)initUI {
    _message = @"Tap to add RTSP!";
    self.alpha = 0;
    [self setTitle:self.message forState:UIControlStateNormal];
    [self setTitleColor:UIColor.systemGrayColor forState:UIControlStateNormal];
    self.tintColor = UIColor.systemGray3Color;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:22];
}

- (void)setUI {
    self.titleEdgeInsets = UIEdgeInsetsMake(self.frame.size.height * 1.3, 0, 0, 0);
    [self.titleLabel sizeToFit];
}

#pragma mark - Methods

- (void)isVisible:(BOOL)isOn {
    isOn ? [self show] : [self hide];
}

- (void)show {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|
                                     UIViewAnimationOptionTransitionCrossDissolve)
                         animations:^{ self.alpha = 1; }
                         completion:nil];
    });
}

- (void)hide {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5
                              delay:0
                            options:(UIViewAnimationOptionAllowAnimatedContent|
                                     UIViewAnimationOptionTransitionCrossDissolve)
                         animations:^{ self.alpha = 0; }
                         completion:nil];
    });
}

@end
