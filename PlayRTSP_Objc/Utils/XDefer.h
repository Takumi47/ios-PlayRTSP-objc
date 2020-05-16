//
//  XDefer.h
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDefer : NSObject

+ (instancetype)block:(void(^)(void))block;

@end
