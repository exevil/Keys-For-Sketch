//
//  KeyItemContextMenu.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 20/05/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class ItemCellContextualMenu: NSMenu {
    
    // MARK: Init
    
    /// Associated KeyItem.
    let menuItem: NSMenuItem
    
    required init(menuItem: NSMenuItem) {
        self.menuItem = menuItem
        super.init(title: "")
        self.autoenablesItems = false
        
        addItem(withTitle: "Remove", action: #selector(restoreDefaultShortcut), keyEquivalent: "").target = self
    }
    
    // Since we can only init with keyItem, use fatalError on required initializer
    required init(coder decoder: NSCoder) {
        fatalError("ItemCellContextualMenu can only be initialized with init(keyItem:)")
    }
    
    // MARK: Actions
    
    /// Restore default shortcut for clicked item.
    @objc func restoreDefaultShortcut() {
        menuItem.shortcut = nil
    }
}
