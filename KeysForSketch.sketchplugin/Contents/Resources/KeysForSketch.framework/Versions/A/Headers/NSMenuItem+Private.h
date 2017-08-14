//
//  NSMenuItem+Private.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 27/07/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/// A category used to get access to NSMenuItem's private methods.
@interface NSMenuItem (Private)

/// Key Equivalent that menu item holds directly inside self
- (NSString *)_rawKeyEquivalent;
/// Modifier Mask that menu item holds directly inside self
- (unsigned long long)_rawKeyEquivalentModifierMask;

/// When NO is passed, this method will recache user key equivalents immediately.
- (void)_recacheUserKeyEquivalentOnlyIfStale:(BOOL)arg1;

/// Return pointer to internal static AppKit dictionary with cached user Key Equivalents.
+ (void **)sAppKeyEquivalents;
@end
