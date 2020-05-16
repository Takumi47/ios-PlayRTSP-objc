//
//  CALayer+Shadow.h
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (Shadow)

- (void)roundCornersWithRadius:(CGFloat)radius;
- (void)addShadowWithOffset:(CGSize)offset
                    opacity:(float)opacity
                     radius:(CGFloat)radius
                      color:(UIColor*)color;

@end
