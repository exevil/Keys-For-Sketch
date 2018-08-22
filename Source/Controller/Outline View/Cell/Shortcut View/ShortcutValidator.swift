//
//  ShortcutValidator.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 02/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Foundation

class ShortcutValidator : MASShortcutValidator {
    
    static let sharedInstance = ShortcutValidator()
    // Return the same shared instance to override Obj-C superclass singleton method
    override static func shared() -> ShortcutValidator {
        return ShortcutValidator.sharedInstance
    }
    
    func isShortcutValid(_ shortcut: MASShortcut!, validWithoutModifiers: Bool) -> Bool {
        let keyCode = Int(shortcut.keyCode)
        let modifiers = shortcut.modifierFlags
        
        // Allow any function key with any combination of modifiers
        let includesFunctionKey: Bool = {
            let fKeyCodes = [kVK_F1, kVK_F2, kVK_F3, kVK_F4, kVK_F5, kVK_F6, kVK_F7, kVK_F8, kVK_F9, kVK_F10, kVK_F11, kVK_F12, kVK_F13, kVK_F14, kVK_F15, kVK_F16, kVK_F17, kVK_F18, kVK_F19, kVK_F20]
            for fKeyCode in fKeyCodes {
                if fKeyCode == keyCode { return true }
            }
            return false
        }()
        if includesFunctionKey { return true }
        
        // Check for modifiers
        let hasModifierFlags = modifiers > 0
        if !hasModifierFlags && validWithoutModifiers { return true }
        
        // Allow any hotkey containing Control or Command modifier
        let includesCmd = modifiers & NSEvent.ModifierFlags.command.rawValue > 0
        let includesCtrl = modifiers & NSEvent.ModifierFlags.control.rawValue > 0
        // Allow Option key only in selected cases
        let includesCorrectOption: Bool = {
            if modifiers & NSEvent.ModifierFlags.control.rawValue > 0 {
                // Always allow Option-Space and Option-Escape because they do not have any bind system commands
                if keyCode == kVK_Space || keyCode == kVK_Escape { return true }
                
                // Allow Option modifier with any key even if it will break the system binding
                if self.allowAnyShortcutWithOptionModifier { return true }
            }
            return false
        }()
        if includesCmd || includesCtrl || includesCorrectOption {
            return true
        }
        
        // The hotkey violates system bindings
        return false
    }
}
