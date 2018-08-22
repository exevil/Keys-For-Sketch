//
//  NSMenu+Additions.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 05/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public extension NSMenu {
    
    // MARK: Common
    
    /// True if NSMenu is a child of Application's mainMenu.
    func isChildOf(_ menu: NSMenu) -> Bool {
        var currentSupermenu = supermenu
        while currentSupermenu != nil {
            if currentSupermenu == menu { return true }
            currentSupermenu = currentSupermenu?.supermenu
        }
        return false
    }
    
    /// Enclosing Menu Item.
    var superitem: NSMenuItem? {
        return supermenu?.items.filter{ $0.submenu == self }[0]
    }
    
    // MARK: Iterate
    
    /// Iterate over all KeyItems placed deeper in hierarchy and execute given closure for each of it.
    func iterateAndExecute(_ closure: (_ menuItem: NSMenuItem) -> Void) {
        items.forEach { item in
            closure(item)
            item.submenu?.iterateAndExecute(closure)
        }
    }
    
    /// Find KeyItem placed deeper in hierarchy by its shortcut.
    func findItem(by shortcut: MASShortcut) -> NSMenuItem? {
        var resulItem: NSMenuItem? = nil
        iterateAndExecute { item in
            if item.shortcut == shortcut {
                resulItem = item
            }
        }
        return resulItem
    }
}
