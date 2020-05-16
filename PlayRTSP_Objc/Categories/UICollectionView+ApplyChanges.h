//
//  UICollectionView+ApplyChanges.h
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface UICollectionView (ApplyChanges)

- (void)applyWithChanges:(RLMCollectionChange*)changes;

@end
