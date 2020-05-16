//
//  RTSPView.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPView.h"
#import "UIView+Shake.h"
#import "UIView+NibLoadable.h"
#import "CALayer+Shadow.h"

@implementation RTSPView

#pragma mark - Lifecycle

- (void)setObject:(RTSPItem *)object {
    _object = object;
    if (!object) { return; }
    
    self.nameLabel.text = object.name;
    self.urlLabel.text = object.url;
    
    // TODO:
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonSetup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self fromNib];
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self fromNib];
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup {
    self.containerView.clipsToBounds = true;
    self.containerView.layer.cornerRadius = 5;
    
    [self.layer addShadowWithOffset:CGSizeMake(2, 4) opacity:0.6 radius:2 color:UIColor.darkGrayColor];
}

#pragma mark - Selector

- (IBAction)onPlayButtonTapped:(id)sender {
    if (!self.object) { return; }
    self.playHandler(self.object.uuid, self.object.url);
}

- (IBAction)onDeleteButtonTapped:(id)sender {
    if (!self.object) { return; }
    self.deletionHandler(self.object.uuid);
}

#pragma mark - Methods

- (void)setShakingEnabled:(BOOL)enabled {
    [UIView transitionWithView:self.deleteButton
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ [self.deleteButton setHidden:!enabled]; }
                    completion:nil];
    if (enabled) {
        [self.deleteButton startShaking];
        [self.containerView startShaking];
    } else {
        [self.deleteButton stopShaking];
        [self.containerView stopShaking];
    }
}

- (void)clear {
    self.object = nil;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
}

@end
