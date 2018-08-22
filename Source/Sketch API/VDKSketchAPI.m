//
//  SketchAPI.m
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 18/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

#import "VDKSketchAPI.h"
#import <objc/runtime.h>
#import <KeysForSketch/KeysForSketch-Swift.h>

@implementation VDKSketchAPI

+ (NSArray<Protocol *> *)protocols {
    return SketchAPITools.protocols;
}

// MARK: General

+ (NSWindowController<VDKSketchMSPreferencesControllerProtocol> *)preferencesController {
    NSError *error;
    Class sketchClass = [SketchAPITools
                         sketchClassFrom:@protocol(VDKSketchMSPreferencesControllerProtocol)
                         error:&error];
    return [sketchClass sharedController];
    // TODO: Handle Error
}

+ (nonnull NSObject<VDKSketchAppControllerProtocol> *)appController {
    return [NSClassFromString(@"AppController") sharedInstance];
}

+ (nonnull NSObject<VDKSketchMSKeyBindingsProtocol> *)keyBindingsController {
    return [NSClassFromString(@"MSKeyBindings") sharedInstance];
}

// MARK: Document

+ (nonnull NSDocumentController<VDKSketchMSDocumentControllerProtocol> *)sharedDocumentController {
    return [NSClassFromString(@"MSDocumentController") sharedDocumentController];
}

+ (nullable NSDocument<VDKSketchMSDocumentProtocol> *)currentDocument {
    return [NSClassFromString(@"MSDocument") currentDocument];
}

@end
