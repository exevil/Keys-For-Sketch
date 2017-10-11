//
//  VDKSketchMSNormalInspectorProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 17/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//
@protocol VDKSketchMSStandardInspectorViewControllersProtocol;

@protocol VDKSketchMSNormalInspectorProtocol

@property(nonnull, readonly, nonatomic) NSObject<VDKSketchMSStandardInspectorViewControllersProtocol> *standardInspectors;

@end
