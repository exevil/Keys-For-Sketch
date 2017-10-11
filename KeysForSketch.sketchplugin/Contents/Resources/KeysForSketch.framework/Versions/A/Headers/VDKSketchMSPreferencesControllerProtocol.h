//
//  VDPreferencesControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 27/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

@protocol VDKSketchMSPreferencesControllerProtocol <NSToolbarDelegate>

@property(nullable, nonatomic) __weak NSToolbar *toolbar;
@property(nullable, copy, nonatomic) NSArray<NSToolbarItemIdentifier> *toolbarItemIdentifiers;
@property(nonnull, copy, nonatomic) NSDictionary<NSToolbarItemIdentifier, Class> *preferencePaneClasses;
@property(nonatomic) unsigned long long selectedTabIndex;

- (void)switchToPaneWithIdentifier:(nonnull NSToolbarItemIdentifier)arg1;
@end
