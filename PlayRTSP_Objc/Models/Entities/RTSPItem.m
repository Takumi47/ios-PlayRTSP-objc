//
//  RTSPItem.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPItem.h"

@implementation RTSPItem

+ (NSString *)primaryKey {
    return @"uuid";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
        @"uuid"       : [[NSUUID UUID]UUIDString],
        @"name"       : @"",
        @"url"        : @"",
        @"createdDate": [NSDate date]
    };
}

@end
