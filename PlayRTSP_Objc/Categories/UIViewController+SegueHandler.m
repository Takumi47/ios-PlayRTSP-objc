//
//  UIViewController+SegueHandler.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "UIViewController+SegueHandler.h"

@implementation UIViewController (SegueHandler)

- (NSString*)segueIdentifierToString:(SegueIdentifier)segueId {
    NSArray *identifiers = [[NSArray alloc] initWithObjects:kSegueIdentifier];
    return [identifiers objectAtIndex:segueId];
}

- (SegueIdentifier)segueIdentifierFromSegue:(UIStoryboardSegue*)segue {
    NSString *segueId = segue.identifier;
    NSArray *identifiers = [[NSArray alloc]initWithObjects:kSegueIdentifier];
    NSUInteger n = [identifiers indexOfObject:segueId];
    if(n < 1) n = Detail;
    return (SegueIdentifier)n;
}

- (void)performSegueWithSegueIdentifier:(SegueIdentifier)segueIdentifier
                            sender:(id)sender {
    NSString *identifier = [self segueIdentifierToString:segueIdentifier];
    [self performSegueWithIdentifier:identifier sender:sender];
}

@end
