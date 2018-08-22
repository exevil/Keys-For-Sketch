//
//  ShortcutErrorHandler.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 25/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Foundation

class ShortcutErrorHandler: NSObject {
    
    static let shared = ShortcutErrorHandler()
    
    /// View Controller to display error alerts.
    /// - important: Explicitly unwrapped since you can produce an error alert only when controller is successfully initialized.
    let viewController: ViewController = ViewController.initialized!
    
    /// Currently presented Error Sheet.
    var presentedErrorSheet: NSAlert?
    
    /// Begin Error Sheet in viewController.
    func beginErrorSheet(with shortcut: MASShortcut, explanation: String, sender: ShortcutView) {
        endErrorSheetIfDisplayed()
        
        let errorAlert = ShortcutErrorAlert(with: shortcut, explanation: explanation)
        presentedErrorSheet = errorAlert
        errorAlert.beginSheetModal(for: viewController.view.window!, completionHandler: { (response) -> Void in
            
            // MARK: Cancel button
            if response == .alertFirstButtonReturn {
                errorAlert.window.sheetParent?.endSheet(errorAlert.window)
            }
            
            if let conflictKeyItem = Const.Menu.main.findItem(by: shortcut) {
                // MARK: Set Anyway button
                if response == .alertSecondButtonReturn {
                    sender.menuItem.shortcut = shortcut
                    conflictKeyItem.shortcut = nil
                }
                
                // MARK: To Conflict Button
                if response == .alertThirdButtonReturn {
                    // If search is used, clear it to access a conflict item even if it's not currently shown in Outline View.
                    if
                        let dataSource = self.viewController.outlineView.dataSource as? OutlineViewDataSource,
                        dataSource.searchPhrase != ""
                    {
                        dataSource.searchPhrase = ""
                        self.viewController.outlineView.reloadData()
                    }
                    
                    // Collect all parents hierarchy of conflicted item
                    var items = [conflictKeyItem]
                    if var parent = conflictKeyItem.parent {
                        items.append(parent)
                        while parent.parent != nil {
                            let parentOfParent = parent.parent!
                            items.append(parentOfParent)
                            parent = parentOfParent
                        }
                    }
                    
                    // Reverse array to expand parents in right order
                    items.reverse()
                    // Expand items and blink a latest one
                    for item in items {
                        if item == items.last {
                            let itemRow = self.viewController.outlineView.row(forItem: item)
                            self.viewController.outlineView.scrollRowToVisible(itemRow)
                            // Blink item cell
                            if let itemCellView = self.viewController.outlineView.view(atColumn: 0, row: itemRow, makeIfNecessary: false) as? ItemTableCellView {
                                itemCellView.blink(with: NSColor(calibratedRed: 250/255.0, green: 100/255.0, blue: 93/255.0, alpha: 0.4), forDuration: 0.75)
                            }
                        } else {
                            self.viewController.outlineView.expandItem(item)
                        }
                    }
                }
            }
            
            // Anyway stop listening for shortcut updates when alert is closed
            sender.eventMonitoringIsActive = false
        })
    }
    
    /// End currently shown error sheet.
    func endErrorSheetIfDisplayed() {
        if let errorSheet = presentedErrorSheet {
            errorSheet.window.sheetParent?.endSheet(errorSheet.window)
        }
    }
}
