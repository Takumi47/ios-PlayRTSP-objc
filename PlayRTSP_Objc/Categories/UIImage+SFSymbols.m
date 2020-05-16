//
//  UIImage+SFSymbols.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIImage+SFSymbols.h"

@implementation UIImage (SFSymbols)

+ (UIImageConfiguration*)defaultConfig {
    return [UIImageSymbolConfiguration configurationWithPointSize:30 weight:UIImageSymbolWeightRegular];
}
- (UIImage*)play {
    return [UIImage systemImageNamed:@"play.fill" withConfiguration:[UIImage defaultConfig]];
}
- (UIImage*)stop {
    return [UIImage systemImageNamed:@"stop.fill" withConfiguration:[UIImage defaultConfig]];
}

@end
