//
//  RealmProvider.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RealmProvider : NSObject

@property (class, nonatomic, readonly) RealmProvider *rtsp;
@property (nonatomic, readonly) RLMRealm *realm;

@end
