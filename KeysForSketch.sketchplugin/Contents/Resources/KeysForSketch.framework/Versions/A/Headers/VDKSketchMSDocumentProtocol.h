//
//  VDKMSDocumentProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 20/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSActionControllerProtocol, VDKSketchMSLayerArrayProtocol, VDKSketchMSDocumentDataProtocol, VDKSketchMSInspectorControllerProtocol;

@protocol VDKSketchMSDocumentProtocol

@property(nonnull, retain, nonatomic) NSObject<VDKSketchMSDocumentDataProtocol> *documentData;
@property(nonnull, retain, nonatomic) NSObject<VDKSketchMSActionControllerProtocol> *actionsController;
@property(nonnull, retain, nonatomic) NSViewController<VDKSketchMSInspectorControllerProtocol> *inspectorController;
@property(nullable, copy, nonatomic) NSObject<VDKSketchMSLayerArrayProtocol> *selectedLayers;

+ (nullable instancetype)currentDocument;

@end
