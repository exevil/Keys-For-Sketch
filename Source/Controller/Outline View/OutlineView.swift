//
//  OutlineView.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 02/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class OutlineView: NSOutlineView {
    
    override func makeView(withIdentifier identifier: NSUserInterfaceItemIdentifier, owner: Any?) -> NSView? {
        let view = super.makeView(withIdentifier: identifier, owner: owner)
        
        // Custom disclosure icons
        if identifier == NSOutlineView.disclosureButtonIdentifier {
            (view as! NSButton).image = image(Const.Image.disclosureVertiacal)
            (view as! NSButton).alternateImage = image(Const.Image.disclosureHorizontal)
        }
        
        return view
    }
    
    // Remove default cell separator
    override var intercellSpacing: NSSize {
        get {
            return NSSize(width: 0, height: 0)
        }
        set {}
    }
    
    // MARK: Double Action
    
    override var doubleAction: Selector? {
        get {
            return #selector(doubleActionHandler)
        }
        set {}
    }
    
    @objc func doubleActionHandler() {
        if let item = item(atRow: clickedRow), let view = view(atColumn: 0, row: clickedRow, makeIfNecessary: false) as? ItemTableCellView {
            let optionPressed = (NSApp.currentEvent!.modifierFlags.rawValue & NSEvent.ModifierFlags.option.rawValue) == NSEvent.ModifierFlags.option.rawValue
            
            // Play blink animation
            view.blink(with: NSColor.lightGray.withAlphaComponent(0.25), forDuration: 0.2)
            
            // Expand/Collapse item based on its current state
            isItemExpanded(item) ?
                animator().collapseItem(item, collapseChildren: optionPressed) :
                animator().expandItem(item, expandChildren: optionPressed)
        }
    }
}

extension NSOutlineView {
    /// Make function that automatically assigns given Key Item.
    func makeView(withIdentifier identifier: NSUserInterfaceItemIdentifier, owner: Any?, menuItem: NSMenuItem) -> ItemTableCellView? {
        let view = super.makeView(withIdentifier: identifier, owner: owner) as? ItemTableCellView
        view?.menuItem = menuItem
        return view
    }
    
    /// A KeyItem at clicked row or nil if no Key Item found.
    var clickedMenuItem: NSMenuItem? {
        return item(atRow: clickedRow) as? NSMenuItem
    }
}
