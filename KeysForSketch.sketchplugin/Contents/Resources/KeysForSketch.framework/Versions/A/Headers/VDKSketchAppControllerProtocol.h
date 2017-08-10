//
//  VDKSketchAppControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 22/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSPluginManagerWithActionsProtocol;

@protocol VDKSketchAppControllerProtocol <NSObject>

@property(retain, nonatomic) id<VDKSketchMSPluginManagerWithActionsProtocol> pluginManager;

+ (id)sharedInstance;
- (void)menuNeedsUpdate:(id)arg1;

@end
