//
//  VDKSketchMSDocumentDataProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 03/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSPageProtocol;

@protocol VDKSketchMSDocumentDataProtocol

@property(nonnull, readonly, nonatomic) NSArray<NSObject<VDKSketchMSPageProtocol>*> *pages;

@end
