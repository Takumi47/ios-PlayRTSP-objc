//
//  UIViewController+SegueHandler.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Detail
} SegueIdentifier;

#define kSegueIdentifier @"Detail", nil

@interface UIViewController (SegueHandler)

- (NSString*)segueIdentifierToString:(SegueIdentifier)segueId;
- (SegueIdentifier)segueIdentifierFromSegue:(UIStoryboardSegue*)segue;
- (void)performSegueWithSegueIdentifier:(SegueIdentifier)segueIdentifier
                                 sender:(id)sender;

@end
