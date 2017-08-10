//
//  VDKSketchMSDocumentControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 27/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSDocumentControllerProtocol <NSObject>

+ (instancetype)sharedDocumentController;
- (void)openDocumentWithContentsOfURL:(NSURL *)arg1 display:(BOOL)arg2 completionHandler:(void (^)(NSDocument *document, BOOL documentWasAlreadyOpen, NSError *error))arg3;

@end
