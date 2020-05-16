//
//  RTSPItem.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RTSPItem : RLMObject

@property NSString *uuid;
@property NSString *name;
@property NSString *url;
@property NSDate   *createdDate;

@end
