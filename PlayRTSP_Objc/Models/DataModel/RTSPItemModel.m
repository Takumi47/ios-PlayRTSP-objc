//
//  RTSPItemModel.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPItemModel.h"
#import "RealmProvider.h"

@interface RTSPItemModel ()

@property (class, nonatomic, readonly) RealmProvider *provider;
@property (class, nonatomic, strong) RLMNotificationToken *token;

@end

@implementation RTSPItemModel

static RLMNotificationToken *_token;
static ChangesCallback _didUpdate;

#pragma mark - Lifecycle

+ (RealmProvider*)provider {
    return RealmProvider.rtsp;
}

+ (RLMResults*)items {
    RLMResults *allObjects = [RTSPItem allObjectsInRealm:self.provider.realm];
    RLMResults *sortedObjects = [allObjects sortedResultsUsingKeyPath:@"createdDate" ascending:true];
    return sortedObjects;
}

+ (void)setToken:(RLMNotificationToken *)token {
    _token = token;
}

+ (RLMNotificationToken *)token {
    return _token;
}

+ (void)setDidUpdate:(ChangesCallback)didUpdate {
    _didUpdate = didUpdate;
    
    if (didUpdate) {
        self.token = [self.items addNotificationBlock:^(RLMResults *results, RLMCollectionChange *changes, NSError * error) {
            if (error) {
                NSLog(@"Failed to open Realm on background worker: %@", error);
                return;
            }
            didUpdate(changes);
        }];
    } else {
        [self.token invalidate];
    }
}

+ (ChangesCallback)didUpdate {
    return _didUpdate;
}

#pragma mark - Methods

+ (RTSPItem*)fetchWithUUID:(NSString*)uuid {
    return [RTSPItem objectInRealm:self.provider.realm forPrimaryKey:uuid];
}

+ (void)addWithName:(NSString*)name
                url:(NSString*)url {
    RTSPItem *item = [[RTSPItem alloc]initWithValue:@{
        @"name": name,
        @"url" : url
    }];
    [self doTransactionWithBlock:^{
        [self.provider.realm addObject:item];
    }];
}

+ (void)deleteWithUUID:(NSString*)uuid {
    RTSPItem *item = [self fetchWithUUID:uuid];
    if (item) {
        [self doTransactionWithBlock:^{
            [self.provider.realm deleteObject:item];
        }];
    }
}

+ (void)doTransactionWithBlock:(void (^)(void))block {
    [self.provider.realm beginWriteTransaction];
    block();
    [self.provider.realm commitWriteTransaction];
}

@end
