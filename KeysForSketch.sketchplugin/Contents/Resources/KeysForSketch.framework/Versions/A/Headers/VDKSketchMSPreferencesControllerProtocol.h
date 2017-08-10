//
//  VDPreferencesControllerProtocol.h
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 27/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

// Silence clang warnings
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

@protocol VDKSketchMSPreferencesControllerProtocol <NSToolbarDelegate>

@property (getter=isWindowLoaded, readonly) BOOL windowLoaded;
@property (nullable, strong) NSWindow *window;
@property(nonatomic) __weak NSToolbar *toolbar;
@property(retain, nonatomic, nullable) NSCache *preferencePanes;
@property(copy, nonatomic) NSDictionary *preferencePaneClasses;
@property(copy, nonatomic) NSArray *toolbarItemIdentifiers;
@property(retain, nonatomic) NSViewController *currentPreferencePane;
@property(nonatomic) unsigned long long selectedTabIndex;

+ (instancetype)sharedController;

- (BOOL)validateToolbarItem:(id)arg1;
- (id)toolbar:(id)arg1 itemForItemIdentifier:(id)arg2 willBeInsertedIntoToolbar:(BOOL)arg3;
- (id)toolbarSelectableItemIdentifiers:(id)arg1;
- (id)toolbarDefaultItemIdentifiers:(id)arg1;
- (id)toolbarAllowedItemIdentifiers:(id)arg1;
- (void)updateWindowFrame;
- (void)switchToPaneWithIdentifier:(id)arg1;
- (void)switchPanes:(id)arg1;
- (void)adjustColorsAction:(id)arg1;
- (void)awakeFromNib;

- (void)loadWindow;
- (IBAction)showWindow:(id)sender;
- (void)close;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) Class superclass;

@end

#pragma clang diagnostic pop
