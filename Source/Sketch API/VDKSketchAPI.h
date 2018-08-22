//
//  VDKSketchAPI.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 18/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//
#import <Cocoa/Cocoa.h>

#import "VDKSketchAppControllerProtocol.h"
#import "VDKSketchMSPreferencesControllerProtocol.h"
#import "VDKSketchMSKeyBindingsProtocol.h"
// Document
#import "VDKSketchMSDocumentControllerProtocol.h"
#import "VDKSketchMSDocumentProtocol.h"
#import "VDKSketchMSDocumentDataProtocol.h"
#import "VDKSketchMSActionControllerProtocol.h"
// - Inspector
#import "VDKSketchMSInspectorControllerProtocol.h"
#import "VDKSketchMSNormalInspectorProtocol.h"
#import "VDKSketchMSStandardInspectorViewControllersProtocol.h"
#import "VDKSketchMSLayerInspectorViewControllerProtocol.h"
// Layers
#import "VDKSketchMSLayerArrayProtocol.h"
#import "VDKSketchMSPageProtocol.h"
#import "VDKSketchMSArtboardGroupProtocol.h"
#import "VDKSketchMSLayerGroupProtocol.h"
#import "VDKSketchMSLayerProtocol.h"

@interface VDKSketchAPI : NSObject

/// Array of API protocols that represents selected methods from its corresponding Sketch Classes.
@property (nonatomic, readonly, class) NSArray<Protocol *> * _Nonnull protocols;

// MARK: General

+ (NSWindowController<VDKSketchMSPreferencesControllerProtocol> *_Nonnull)preferencesController;
+ (NSObject<VDKSketchAppControllerProtocol> *_Nonnull)appController;
+ (NSObject<VDKSketchMSKeyBindingsProtocol> *_Nonnull)keyBindingsController;

// MARK: Document

+ (NSDocumentController<VDKSketchMSDocumentControllerProtocol> *_Nonnull)sharedDocumentController;
+ (NSDocument<VDKSketchMSDocumentProtocol> *_Nullable)currentDocument;

@end
