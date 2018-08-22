//
//  ShortcutErrorAlert.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 05/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class ShortcutErrorAlert: NSAlert {
    
    var keysShortcutshortcut: MASShortcut?
    
    var setAnywayButton: NSButton?
    var toConflictButton: NSButton?
    
    convenience init(with shortcut: MASShortcut, explanation: String) {
        self.init()
        alertStyle = .critical
        messageText = "The key combination \(shortcut) cannot be used"
        informativeText = explanation
        // Add Cancel button and assign it Escape keyEquivalent
        addButton(withTitle: "Cancel").keyEquivalent = "\u{1b}"
        
        // If conflicted shortcut reserved by Menu Item not represented by KeyItem options below are not allowed
        if Const.Menu.main.findItem(by: shortcut) != nil {
            setAnywayButton = addButton(withTitle: "Set Anyway")
            toConflictButton = addButton(withTitle: "To Conflict")
        }
        
        window.initialFirstResponder = toConflictButton
    }
}
