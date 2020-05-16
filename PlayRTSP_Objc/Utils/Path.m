//
//  Path.m
//  PlayRTSP_Objc
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "Path.h"

@implementation Path

+ (NSURL*)inLibraryWithName:(NSString*)name {
    NSURL *base = [NSFileManager.defaultManager URLForDirectory:NSLibraryDirectory
                                                       inDomain:NSUserDomainMask
                                              appropriateForURL:nil
                                                         create:false
                                                          error:nil];
    return [base URLByAppendingPathComponent:name];
}

@end
