//
//  ToolsManager.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 28/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class ToolsManager : NSObject {
    
    /// Sketch KeyBindings ShortcutMap dictionary contains mapping of tools action class names to its key equivalents.
    static var sketchShortcutMap: [String : String] {
        get {
            return VDKSketchAPI.keyBindingsController().shortcutMap as! [String : String]
        }
        set {
            // Update Sketch's KeyBindingsController shortcutMap current value
            VDKSketchAPI.keyBindingsController().shortcutMap.removeAllObjects()
            VDKSketchAPI.keyBindingsController().shortcutMap.setDictionary(newValue)
            
            // Update singleKeysShortcuts dict of action controllers of all opened documents which is storing an original KeyBindings shortcutMap value during initialization and won't updating it automatically.
            for case let doc as VDKSketchMSDocumentProtocol in NSApp.orderedDocuments {
                doc.actionsController.singleKeyShortcuts = newValue
            }
            
            // Store new value in User Key Bindings plist file to load it automatically when Sketch will start next time
            NSDictionary(dictionary: newValue).write(toFile: VDKSketchAPI.keyBindingsController().userKeyBindingsPath(), atomically: true)
        }
    }
    
    /// Default Sketch tools shortcut mapping.
    static var sketchDefaultKeyBindings: [String : String] {
        // TODO: Need to test
        return NSDictionary(contentsOfFile: VDKSketchAPI.keyBindingsController().defaultKeyBindingsPath()) as! [String : String]
    }
    
    // MARK: Shortcut
    
    /// Bind Shortcut for given Tool KeyItem via Sketch Key Bindings if needed.
    class func setToolShortcutIfNeeded(for menuItem: NSMenuItem) {
        if !menuItem.isTool { return }
        
        inDebug { print("Set tool shortcut for: ", menuItem.title) }
        
        // If the new shortcut is empty, remove its bindning
        guard let menuItemShortcut = menuItem.shortcut else {
            restoreDefaultToolShortcut(for: menuItem)
            return
        }
        
        // If given shortcut is a multi-character one remove previous single-character shortcut for tool from KeyBindings if exist without setting a new one because now app menu itself can manage the shortcut handling
        if menuItemShortcut.modifierFlags != 0 {
            restoreDefaultToolShortcut(for: menuItem)
            return
        }
        
        // Make sure that key has proper Key Equivalent and associated class
        if let keyEquivalents = KeyCodeTransformer.keyEquivalents(for: menuItemShortcut.keyCode) {
            // Get target class name and use it as a key to set new value to Sketch shortcutMap
            sketchShortcutMap[menuItem.targetTypeName] = keyEquivalents.joined()
        }
    }
    
    /// Remove shortcut of given tool KeyItem in Sketch Key Bindings.
    class func restoreDefaultToolShortcut(for menuItem: NSMenuItem) {
        if let defaultValue = sketchDefaultKeyBindings[menuItem.targetTypeName] {
            sketchShortcutMap[menuItem.targetTypeName] = defaultValue
        } else {
            sketchShortcutMap[menuItem.targetTypeName] = nil
        }
    }
}
