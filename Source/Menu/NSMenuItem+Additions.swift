//
//  NSMenuItem+Additions.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 17/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public extension NSMenuItem {
    
    // MARK: Keys Checks
    
    /// Decide which Menu Item should be presented to user.
    var shouldBeDisplayedInKeys: Bool {
        // Alternate menuItems shouldn't have unique shortcut
        if isAlternate { return false }
        // If menuItem matches any of the manually defined exceptions, return false as well
        if Const.MenuItem.customizableShortcutExceptions.contains(where: { $0 == (title, parent?.title ?? "") }) { return false }
        
        return true
    }
    
    /// Determines should Key Item have a shortcut or not.
    var needsShortcut: Bool {
        if hasSubmenu || isSeparatorItem {
            return false
        }
        return true
    }
    
    // MARK: Shortcut
    
    /// Calculate individual key string to store shortcut value in System Preferences.
    var defaultsKey: String {
        var parentsTitles = [String]()
        
        var itemToLoop: NSMenuItem? = self
        while itemToLoop != nil {
            parentsTitles.append(itemToLoop!.title)
            itemToLoop = itemToLoop!.parent
        }
        
        return "\u{1B}" + parentsTitles.reversed().joined(separator: "\u{1B}")
    }
    
    /// Tools can have single a character shortcut and special binding after shortcut is set.
    var isTool: Bool {
        // Сheck if menu item is part of Insert menu
        var parentToCheck = parent
        while parentToCheck != nil {
            if parentToCheck?.title == "Insert" {
                return true
            }
            parentToCheck = parentToCheck?.parent
        }
        
        // TODO: Possibly add target class matching check
        
        return false
    }
    
    /// Check if menu item has custom shortcut assigned.
    var hasCustomShortcut: Bool {
        guard let currentShortcuts = CFPreferencesCopyAppValue(Const.Preferences.kUserKeyEquivalents, kCFPreferencesCurrentApplication) as? [String : String] else {
            assertionFailure("Can't get App's User Key Equivalents dict.")
            return false
        }
            return currentShortcuts[defaultsKey] != nil
    }
    
    /// Computed property that represents shortcut that currently associated with KeyItem.
    @objc var shortcut: MASShortcut? {
        get {
            return MASShortcut(keyEquivalent: keyEquivalent, modifierFlags: keyEquivalentModifierMask)
        }
        set {
            if needsShortcut {
                // Write new user key equivalent value to System Preferences
                writeCFPreferences(for: newValue)
                
                // Clean up AppKit's local user key equivalents cache
                appKeyEquivalents.pointee = nil
                // Recache updated user key equivalents cache from System Preferences and apply the changes
                _recacheUserKeyEquivalentOnlyIfStale(false)
                
                inDebug {
                    print("Shortcut set:\n \(CFPreferencesCopyAppValue( "NSUserKeyEquivalents" as CFString, kCFPreferencesCurrentApplication) ?? [:] as CFPropertyList)")
                }
                
                // Final setup
                ToolsManager.setToolShortcutIfNeeded(for: self)
                ViewController.initialized?.outlineView.reloadItem(self)
            }
        }
    }
    
    // MARK: Other
    
    /// An index of the menu item in enclosing menu.
    /// - important: Returns `nil` if item has no enclosing menu or haven't been included into it for some reason.
    var index: Int? {
        return menu?.index(of: self) != -1 ? menu?.index(of: self) : nil
    }
    
    /// Target object type name
    var targetTypeName: String! {
        if target != nil {
            return String(describing: type(of:target!))
        } else {
            // TODO: Handle Error
            assertionFailure("Can't get menu item target to determine its class.")
            return nil
        }
    }
    
    /// Save given Shortcut to System Preferences
    func writeCFPreferences(for shortcut: MASShortcut?) {
        
        // Copy current values from System Preferences, add a new value and save it back
        
        var currentShortcuts = CFPreferencesCopyAppValue(Const.Preferences.kUserKeyEquivalents, kCFPreferencesCurrentApplication) as? [String : String] ?? [String : String]()
        
        if shortcut != nil {
            let sysPrefsShortcutString = "\(shortcut?.modifierFlagsStringForSystemPreferences ?? "")\(shortcut?.fixedKeyCodeStringForKeyEquivalent ?? "")"
            currentShortcuts[defaultsKey] = sysPrefsShortcutString
        } else {
            currentShortcuts[defaultsKey] = nil
        }
        
        CFPreferencesSetAppValue(Const.Preferences.kUserKeyEquivalents, currentShortcuts as CFPropertyList, kCFPreferencesCurrentApplication)
        CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
        
        // Register application in `com.apple.universalaccess` preference file if needed to get shortcuts shown in System Preferences
        
        guard var custommenuApps = CFPreferencesCopyAppValue(Const.Preferences.kCustomMenuApps, Const.Preferences.kUniversalAccess) as? [String] else {
            assertionFailure("Can't determine \(Const.Preferences.kCustomMenuApps) array from \(Const.Preferences.kUniversalAccess) preferences file")
            return
        }
        
        if !currentShortcuts.isEmpty && !custommenuApps.contains(Bundle.main.bundleIdentifier!) {
            custommenuApps += [Bundle.main.bundleIdentifier!]
            CFPreferencesSetAppValue(Const.Preferences.kCustomMenuApps, custommenuApps as CFPropertyList, Const.Preferences.kUniversalAccess)
            CFPreferencesAppSynchronize(Const.Preferences.kUniversalAccess)
        }
    }
}
