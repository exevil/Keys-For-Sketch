//
//  ShortcutButtonCell.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 04/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class ShortcutButtonCell: NSButtonCell {
    
    override var alignment: NSTextAlignment {
        get {
            return super.alignment
        }
        set {
            switch newValue {
            case .center:
                // Make shortcut string aligned left since default implementation of Shortcut aligns it to center in ShortcutView
                super.alignment = .left
            case .right:
                // Disable display of default hinting buttons
                self.isEnabled = false
            default:
                super.alignment = newValue
            }
        }
    }
    
    override var title: String! {
        didSet {
            // Change "Record Shortcut" to set shortcut
            if title == "Record Shortcut" {
                attributedTitle = NSAttributedString(string: "…", attributes:[NSAttributedStringKey.foregroundColor : NSColor.lightGray])
            }
        }
    }
}
