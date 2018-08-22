//
//  OutlineViewDelegate.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 24/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class OutlineViewDelegate: NSObject, NSOutlineViewDelegate {
    
    @IBOutlet weak var errorHandler: ShortcutErrorHandler!
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        var height: CGFloat = 0 // Should crash if no value is set
        if let menuItem = item as? NSMenuItem {
            if menuItem.isSeparatorItem {
                height = Const.Cell.separatorHeight
            } else {
                height = Const.Cell.height
            }
        }
        return height
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var cell: NSTableCellView?
        if let menuItem = item as? NSMenuItem {
            if menuItem.isSeparatorItem {
                cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "separatorCell"), owner: self) as? NSTableCellView
            } else {
                cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "menuCell"), owner: self, menuItem: menuItem)
            }
        }
        return cell
    }
}
