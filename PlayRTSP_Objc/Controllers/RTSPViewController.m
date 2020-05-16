//
//  RTSPViewController.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPViewController.h"
#import "PlayRTSP_Objc-Swift.h"
#import "XDefer.h"
#import "IJKMediaItem.h"
#import "IJKMediaService.h"

@interface RTSPViewController ()

@property (nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation RTSPViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panGesture = [[UIPanGestureRecognizer alloc]init];
    self.panGesture.delegate = self;
    [self.panGesture addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IJKMediaItem *media = [IJKMediaService.sharedInstance fetchWithUUID:self.uuid];
    UIView *playerView = media.player.view;
    if (self.uuid && media && playerView) {
        media.player.scalingMode = IJKMPMovieScalingModeAspectFit;
        playerView.frame = self.view.bounds;
        self.view.autoresizesSubviews = true;
        [self.view addSubview:playerView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIDeviceOrientation orientation = UIDevice.currentDevice.orientation;
    if ((orientation == UIDeviceOrientationLandscapeLeft) ||
        (orientation == UIDeviceOrientationLandscapeRight)) {
        self.view.contentMode = UIViewContentModeScaleToFill;
    } else {
        self.view.contentMode = UIViewContentModeScaleAspectFit;
    }
}

#pragma mark - Selector

- (void)canRotate {}

- (void)pan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [UIDevice.currentDevice setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                  forKey:@"orientation"];
        [XHero dismiss:self with:^{
            if (self.uuid) {
                [IJKMediaService.sharedInstance removeMediaWithUUID:self.uuid];
            }
        }];
    } else {
        [XHero finishTransition];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint velocity = [self.panGesture velocityInView:nil];
    return velocity.y > fabs(velocity.x);
}

@end
