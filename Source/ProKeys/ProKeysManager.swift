//
//  ProKeysManager.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 21/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class ProKeysManager: NSObject {
    
    /// Array of ProKeys 
    static var proKeys: [ProKeyProtocol] = [ProKeyAspectRatioSwitcher.shared]
    
    /// Insert ProKeys menu items onto its positions.
    @objc public class func injectProKeys() throws {
        for pkey in proKeys {
            
            guard let parentMenu = pkey.parentMenu else { throw Error.cantGetParentMenuOf(proKey: pkey) }
            
            // If there's no specified previous menu item, ProKey's menu items should be inserted at index 0.
            var previousItemIndex = -1
            // If previous item title was set for ProKey, make sure that corresponding menu item exists or throw the error to avoid menu items misplacement.
            if let previousMenuItemTitle = pkey.previousMenuItemTitle {
                guard let prevMenuItem = parentMenu.item(withTitle: previousMenuItemTitle) else { throw Error.cantGetPreviousMenuItemOf(proKey: pkey) }
                previousItemIndex = parentMenu.index(of: prevMenuItem)
            }
            
            for menuItem in pkey.menuItems {
                parentMenu.insertItem(menuItem, at: previousItemIndex + 1)
                previousItemIndex += 1
            }
        }
    }
    
    enum Error: LocalizedError {
        
        case cantGetPreviousMenuItemOf(proKey: ProKeyProtocol)
        case cantGetParentMenuOf(proKey: ProKeyProtocol)
        
        var errorDescription: String? {
            switch self {
            case .cantGetPreviousMenuItemOf(let proKey):
                return "Can't get previous menu item of ProKey: \"\(type(of:proKey))\"."
            case .cantGetParentMenuOf(let proKey):
                return "Can't get parent menu of ProKey: \"\(type(of:proKey))\"."
            }
        }
    }
}
