//
//  VDKeys.h
//  Keys for Sketch
//
//  Created by Vyacheslav Dubovitsky on 11/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VDKeys : NSObject

@property (class, readonly, nonnull) NSBundle *bundle;
@property (class, readonly, nonnull) NSURL *pluginURL;
@property (class, readonly, nonnull) NSString *shortVersion;
@property (class, readonly, nonnull) NSString *prefsIdentifier;

+ (void)start;

@end
