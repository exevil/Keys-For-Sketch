//
//  VDKSketchAppControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 22/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchAppControllerProtocol

+ (nonnull instancetype)sharedInstance;
- (void)refreshCurrentDocument;

@end
