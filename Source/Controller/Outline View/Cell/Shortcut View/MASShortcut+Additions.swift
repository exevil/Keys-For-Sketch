//
//  MASShortcut+Additions.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 17/07/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

extension MASShortcut {
    /// A modifier flags string valid to store modifiers data in System Preferences.
    var modifierFlagsStringForSystemPreferences: String! {
        // Replace modifiers in modifierFlagsString to ones that suitable for System Preferences
       return String(modifierFlagsString.map {
            switch $0 {
            case "⌘":
                return "@"
            case "⌥":
                return "~"
            case "⌃":
                return "^"
            case "⇧":
                return "$"
            default:
                return "\0" // Null character
            }
        })
    }
    
    /// A key-code string used in key equivalent matching. This implementation should fix some problems that default `keyCodeStringForKeyEquivalent` has.
    var fixedKeyCodeStringForKeyEquivalent: String! {
        return KeyCodeTransformer.keyEquivalents(for: keyCode)?[0] ?? ""
    }
    
    /** Init with Key Equivalent string and modifier flags.
     — parameters:
     keyEquivalent: A string that represents character from ANSI keyboard.
     modifierFlags: Used modifier flags.
     */
    convenience init?(keyEquivalent: String, modifierFlags: NSEvent.ModifierFlags) {
        if let itemKeyCode = KeyCodeTransformer.keyCode(for: keyEquivalent) {
            
            var modifierFlagsWithShift: UInt = modifierFlags.rawValue
            // Since NSMenuItem can't capture Shift key as a Modifier Flag try to determine was Shift used during keyEquivalent setup and if so, add it to modifierFlags
            if itemKeyCode.wasShiftKeyUsed {
                modifierFlagsWithShift |= NSEvent.ModifierFlags.shift.rawValue
            }
            
            self.init(keyCode: itemKeyCode.value, modifierFlags: modifierFlagsWithShift)
        } else {
            return nil
        }
    }
}
