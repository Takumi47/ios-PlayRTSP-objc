//
//  XDefer.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "XDefer.h"

@implementation XDefer {

@private void(^_deferBlock)(void);
    
}

+ (instancetype)block:(void (^)(void))block {
   XDefer *_d = [XDefer new];
   _d->_deferBlock = block ?: ^{};
   return _d;
}

- (void)dealloc {
   _deferBlock();
}

@end
