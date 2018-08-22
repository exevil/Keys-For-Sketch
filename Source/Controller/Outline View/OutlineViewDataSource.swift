//
//  OutlineViewDataSource.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 24/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class OutlineViewDataSource: NSObject, NSOutlineViewDataSource {
    
    /// String that represents a search phrase that menu item titles should correspond
    var searchPhrase: String = ""
    
    /// Get the only menu items that need to be displayed by Outline View
    func itemsToDisplay(of menu: NSMenu) -> [NSMenuItem] {
        // Filter restricted items
        var result = menu.items.filter{ $0.shouldBeDisplayedInKeys }
        // Additionaly filter items that not containing searchPhrase if needed
        if !searchPhrase.isEmpty {
            result = result.filter{ $0.title(contains: searchPhrase) }
        }
        
        return result
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        // Get customizable Menu Items count
        if let submenu = (item as? NSMenuItem)?.submenu {
            return itemsToDisplay(of: submenu).count
        }
        return itemsToDisplay(of: Const.Menu.main).count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        // Get customizable Menu Item by index
        if let submenu = (item as? NSMenuItem)?.submenu {
            return itemsToDisplay(of: submenu)[index] as Any
        }
        return itemsToDisplay(of: Const.Menu.main)[index] as Any
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let submenu = (item as? NSMenuItem)?.submenu {
            // Stop menu observer to avoid infinite loop and invoke menuNeedsUpdate method of submenu delegate to let Sketch provide actial menu items data if needed
            MenuObserver.shared.stopObserving()
            submenu.delegate?.menuNeedsUpdate?(submenu)
            MenuObserver.shared.startObserving()
            
            return itemsToDisplay(of: submenu).count > 0
        }
        return false
    }
}

fileprivate extension NSMenuItem {
    /// Recursively check if menu item and its children titles contains given search phrase.
    func title(contains searchPhrase: String) -> Bool {
        switch self {
        case let val where val.title.localizedCaseInsensitiveContains(searchPhrase):
            return true
        case let val where val.hasSubmenu:
            return val.submenu!.items.contains{ $0.title(contains: searchPhrase) }
        default:
            return false
        }
    }
}
