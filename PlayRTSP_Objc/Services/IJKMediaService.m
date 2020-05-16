//
//  IJKMediaService.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "IJKMediaService.h"

@implementation IJKMediaService

#pragma mark - Singleton

+ (instancetype) sharedInstance
{
    static IJKMediaService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IJKMediaService alloc]init];
    });
    return instance;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ijkMediaItems = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Methods

- (BOOL)hasMediaWithUUID:(NSString*)uuid {
    return self.ijkMediaItems[uuid] != nil;
}

- (IJKMediaItem*)fetchWithUUID:(NSString*)uuid {
    return self.ijkMediaItems[uuid];
}

- (void)setMediaWithUUID:(NSString*)uuid
                     url:(NSString*)url {
    if ([self removeMediaWithUUID:uuid]) { return; }
    
    IJKMediaItem *newItem = [[IJKMediaItem alloc]initWithUUID:uuid url:url];
    if (newItem) {
        self.ijkMediaItems[uuid] = newItem;
    }
}

- (BOOL)removeMediaWithUUID:(NSString*)uuid {
    IJKMediaItem *item = [self fetchWithUUID:uuid];
    if (item) {
        [item stop];
        [self.ijkMediaItems removeObjectForKey:uuid];
        return true;
    } else {
        return false;
    }
}

- (void)setSingleMediaWithUUID:(NSString*)uuid {
    for (NSString *_uuid in self.ijkMediaItems.allKeys) {
        if (![_uuid isEqualToString:uuid]) {
            [self removeMediaWithUUID:_uuid];
        }
    }
}

@end
