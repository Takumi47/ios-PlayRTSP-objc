//
//  IJKMediaItem.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "IJKMediaItem.h"

@implementation IJKMediaItem

- (instancetype)initWithUUID:(NSString*)uuid
                         url:(NSString*)url {
    self = [super init];
    if (self) {
        _uuid = uuid;
        _url = url;
        IJKFFOptions *options = IJKFFOptions.optionsByDefault;
        [options setFormatOptionValue:@"tcp" forKey:@"rtsp_transport"];
        
        IJKFFMoviePlayerController *newPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:options];
        if (newPlayer) {
            self.player = newPlayer;
            self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
            self.player.shouldAutoplay = true;
            [self play];
        }
    }
    return self;
}

- (void)play {
    [self.player prepareToPlay];
}

- (void)stop {
    [self.player.view removeFromSuperview];
    [self.player stop];
    self.player = nil;
}

@end
