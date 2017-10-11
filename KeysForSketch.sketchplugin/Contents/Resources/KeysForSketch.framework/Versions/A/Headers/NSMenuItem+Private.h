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

/// When NO is passed, this method will recache user key equivalents immediately.
- (void)_recacheUserKeyEquivalentOnlyIfStale:(BOOL)arg1;
@end
