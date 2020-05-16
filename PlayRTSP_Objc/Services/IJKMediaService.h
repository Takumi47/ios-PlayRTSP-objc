//
//  IJKMediaService.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJKMediaItem.h"

@interface IJKMediaService : NSObject

@property (nonatomic) NSMutableDictionary *ijkMediaItems;



+ (instancetype)sharedInstance;

- (BOOL)hasMediaWithUUID:(NSString*)uuid;

- (IJKMediaItem*)fetchWithUUID:(NSString*)uuid;

- (void)setMediaWithUUID:(NSString*)uuid
                     url:(NSString*)url;

- (BOOL)removeMediaWithUUID:(NSString*)uuid;

- (void)setSingleMediaWithUUID:(NSString*)uuid;

@end
