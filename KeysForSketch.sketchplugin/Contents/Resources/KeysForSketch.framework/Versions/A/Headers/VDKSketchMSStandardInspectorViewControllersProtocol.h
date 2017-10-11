//
//  VDKSketchMSStandardInspectorViewControllersProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 17/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSLayerInspectorViewControllerProtocol;

@protocol VDKSketchMSStandardInspectorViewControllersProtocol

@property(nonnull, readonly, nonatomic) NSViewController<VDKSketchMSLayerInspectorViewControllerProtocol> *layerViewController;

@end
