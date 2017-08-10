//
//  VDKMSDocumentProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 20/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//
#import "VDKMSActionControllerProtocol.h"

@protocol VDKSketchMSDocumentProtocol <NSObject>

@property(retain, nonatomic) NSWindow *documentWindow;
@property(retain, nonatomic) id<VDKMSActionControllerProtocol> actionsController;

+ (id)currentDocument;

@end
