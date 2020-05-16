//
//  UICollectionView+ApplyChanges.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UICollectionView+ApplyChanges.h"
#import "NSArray+HOF.h"

@implementation UICollectionView (ApplyChanges)

- (void)applyWithChanges:(RLMCollectionChange*)changes {
    
    NSArray *deletions = [changes deletionsInSection:0];
    NSArray *insertions = [changes insertionsInSection:0];
    NSArray *updates = [changes modificationsInSection:0];
    
    if ((deletions == nil || deletions.count == 0) &&
        (insertions == nil || insertions.count == 0) &&
        (updates == nil || updates.count == 0)) {
        
        /* initial */
        [UIView transitionWithView:self
                          duration:0.33
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{ [self reloadData]; }
                        completion:nil];
    } else {
        
        /* update */
        self.alpha = 0.7;
        [UIView transitionWithView:self
                          duration:0.33
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
            self.alpha = 1;
            [self performBatchUpdates:^{
                [self deleteItemsAtIndexPaths:deletions];
                [self insertItemsAtIndexPaths:insertions];
                [self reloadItemsAtIndexPaths:updates];
            } completion:nil];
        }
                        completion:nil];
    }
}

@end
