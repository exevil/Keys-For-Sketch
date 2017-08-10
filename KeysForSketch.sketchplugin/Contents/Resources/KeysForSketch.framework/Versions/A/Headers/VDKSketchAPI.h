//
//  VDKeysSketchAPI.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 18/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
// Plugins
#import "VDKSketchMSPluginManagerWithActionsProtocol.h"
#import "VDKSketchMSPluginBundleProtocol.h"
// Other
#import "VDKSketchAppControllerProtocol.h"
#import "VDKSketchMSDocumentProtocol.h"
#import "VDKSketchMSPreferencesControllerProtocol.h"
#import "VDKSketchMSDocumentControllerProtocol.h"
#import "VDKSketchMSKeyBindingsProtocol.h"

@interface VDKSketchAPI : NSObject

// Shared Instances
+ (nonnull NSObject<VDKSketchMSPreferencesControllerProtocol> *)preferencesWindowController;
+ (nonnull id<VDKSketchMSDocumentProtocol>)currentDocument;
+ (nonnull id<VDKSketchAppControllerProtocol>)appController;
+ (nonnull id<VDKSketchMSDocumentControllerProtocol>)documentController;

// Functions
/**
 Update singleKeysShortcuts dict of action controllers of all opened documents with given value
 @note: Action controllers stores an original KeyBindings shortcutMap value during initialization and won't updating it automatically, that's why this method should be called every time after updating a shortcutMap value to apply its changes to all opened documents.
 */
+ (void)updateDocumentsSingleKeyShortcutsWithValue:(nonnull NSDictionary *)newValue;

// Other
+ (nonnull NSURL *)mainPluginsFolderURL;
+ (nonnull id<VDKSketchMSPluginBundleProtocol>)pluginBundleWithURL:(nonnull NSURL *)url;
+ (nonnull id<VDKSketchMSKeyBindingsProtocol>)keyBindingsController;

@end
