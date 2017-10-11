//
//  VDKSketchMSKeyBindingsProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 24/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSKeyBindingsProtocol

@property(nonnull, retain, nonatomic, readonly) NSMutableDictionary<NSString*, NSString*> *shortcutMap;

- (nonnull NSString *)defaultKeyBindingsPath;
- (nonnull NSString *)userKeyBindingsPath;
+ (nonnull instancetype)sharedController;

@end
