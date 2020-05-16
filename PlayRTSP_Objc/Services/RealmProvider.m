//
//  RealmProvider.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RealmProvider.h"
#import "Path.h"
#import "RTSPItem.h"

static const uint64_t kSchemaVersion = 1;

@interface RealmProvider ()

@property (nonatomic) RLMRealmConfiguration *configuration;

@end

@implementation RealmProvider

+ (RealmProvider*)rtsp {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [Path inLibraryWithName:@"rtsp.realm"];
    config.schemaVersion = kSchemaVersion;
    config.objectClasses = @[RTSPItem.class];
    return [[RealmProvider alloc]initWithConfig:config];
}

- (RLMRealm*)realm {
    return [RLMRealm realmWithConfiguration:self.configuration
                                      error:nil];
}

- (instancetype)initWithConfig:(RLMRealmConfiguration*)config
{
    self = [super init];
    if (self) {
        _configuration = config;
    }
    return self;
}

@end
