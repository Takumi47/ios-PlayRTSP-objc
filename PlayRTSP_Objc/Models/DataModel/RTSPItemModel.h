//
//  RTSPItemModel.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "RTSPItem.h"

typedef int DeletedIndex;
typedef int InsertedIndex;
typedef int UpdatedIndex;
typedef void (^ChangesCallback)(RLMCollectionChange*);

@interface RTSPItemModel : NSObject

@property (class, nonatomic, readonly) RLMResults *items;
@property (class, nonatomic) ChangesCallback didUpdate;

+ (RTSPItem*)fetchWithUUID:(NSString*)uuid;

+ (void)addWithName:(NSString*)name
                url:(NSString*)url;

+ (void)deleteWithUUID:(NSString*)uuid;

@end
