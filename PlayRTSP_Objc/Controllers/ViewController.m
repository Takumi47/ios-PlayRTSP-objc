//
//  ViewController.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Theme.h"

NSString * const kDefaultNavigationBarTitle = @"RTSP List";

@interface ViewController ()

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title = kDefaultNavigationBarTitle;
    [self setAppearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAppearance];
}

@end
