//
//  CALayer+Shadow.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "CALayer+Shadow.h"

NSString * const kContentLayerName = @"ContentLayerName";

@implementation CALayer (Shadow)

- (void)roundCornersWithRadius:(CGFloat)radius {
    self.cornerRadius = radius;
    
    if (self.cornerRadius != 0) {
        [self addShadowWithRoundedCorners];
    }
}

- (void)addShadowWithOffset:(CGSize)offset
                    opacity:(float)opacity
                     radius:(CGFloat)radius
                      color:(UIColor*)color; {
    
    self.shadowOffset = offset;
    self.shadowOpacity = opacity;
    self.shadowRadius = radius;
    self.shadowColor = color.CGColor;
    self.masksToBounds = false;
    
    if (self.cornerRadius != 0) {
        [self addShadowWithRoundedCorners];
    }
}

- (void)addShadowWithRoundedCorners {
    if (self.contents) {
        self.masksToBounds = false;
        for (CALayer *layer in self.sublayers) {
            if (CGRectEqualToRect(layer.frame, self.bounds)) {
                [layer roundCornersWithRadius:self.cornerRadius];
            }
        }
        
        self.contents = nil;
        
        if (self.sublayers.firstObject.name == kContentLayerName) {
            [self.sublayers.firstObject removeFromSuperlayer];
        }
        
        CALayer *contentLayer = [[CALayer alloc]init];
        contentLayer.name = kContentLayerName;
        contentLayer.contents = self.contents;
        contentLayer.frame = self.bounds;
        contentLayer.cornerRadius = self.cornerRadius;
        contentLayer.masksToBounds = true;
        
        [self insertSublayer:contentLayer atIndex:0];
    }
}

@end
