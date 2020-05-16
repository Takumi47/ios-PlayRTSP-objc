//
//  RTSPView.h
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTSPItem.h"

typedef void (^PlayHandler)(NSString*, NSString*);
typedef void (^DeletionHandler)(NSString*);

@interface RTSPView : UIView

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic) RTSPItem *object;
@property (nonatomic) PlayHandler playHandler;
@property (nonatomic) DeletionHandler deletionHandler;

- (void)setShakingEnabled:(BOOL)enabled;
- (void)clear;

@end
