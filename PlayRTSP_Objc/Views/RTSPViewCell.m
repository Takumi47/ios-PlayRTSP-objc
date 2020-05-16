//
//  RTSPViewCell.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPViewCell.h"

@implementation RTSPViewCell

#pragma mark - Lifecycle

- (RTSPView*)rtspView {
    if (!_rtspView) {
        _rtspView = [[RTSPView alloc]init];
        _rtspView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_rtspView];
        
        id objects[] = {
            [_rtspView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [_rtspView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [_rtspView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
            [_rtspView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
        };
        NSUInteger count = sizeof(objects) / sizeof(id);
        [NSLayoutConstraint activateConstraints:[NSArray arrayWithObjects:objects count:count]];
    }
    return _rtspView;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.rtspView clear];
}

#pragma mark - Methods

- (void)setShaking:(BOOL)isShaking {
    [self.rtspView setShakingEnabled:isShaking];
}

@end
