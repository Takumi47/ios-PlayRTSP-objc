//
//  IJKMediaItem.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface IJKMediaItem : NSObject

@property (nonatomic) NSString *uuid;
@property (nonatomic) NSString *url;
@property (nonatomic) IJKFFMoviePlayerController *player;

- (instancetype)initWithUUID:(NSString*)uuid
                         url:(NSString*)url;

- (void)play;
- (void)stop;

@end
