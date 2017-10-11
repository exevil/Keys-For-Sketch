//
//  VDKSketchMSInspectorControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 17/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSNormalInspectorProtocol;

@protocol VDKSketchMSInspectorControllerProtocol

@property(nonnull, retain, nonatomic) NSViewController<VDKSketchMSNormalInspectorProtocol> *normalInspector;

@end
