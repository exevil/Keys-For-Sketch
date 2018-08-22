//
//  VDKSketchMSLayerArrayProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 02/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKMSLayerProtocol;

@protocol VDKSketchMSLayerArrayProtocol

@property(nonnull, copy, nonatomic) NSArray<NSObject<VDKMSLayerProtocol>*> *layers;

@end
