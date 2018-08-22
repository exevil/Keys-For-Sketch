//
//  VDKSketchMSPageProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 04/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSLayerGroupProtocol, VDKSketchMSArtboardGroupProtocol;

@protocol VDKSketchMSPageProtocol <VDKSketchMSLayerGroupProtocol>

@property(weak, readonly, nonatomic) NSArray<NSObject<VDKSketchMSArtboardGroupProtocol>*> *artboards;

@end
