//
//  MenuObserver.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 04/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class MenuObserver : NSObject {
    
    @objc public static let shared = MenuObserver()
    let notificationCenter = NotificationCenter.default
    
    @objc public func startObserving() {
        notificationCenter.addObserver(self, selector: #selector(received(notification:)), name: NSMenu.didAddItemNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(received(notification:)), name: NSMenu.didChangeItemNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(received(notification:)), name: NSMenu.didChangeItemNotification, object: nil)
    }
    
    @objc public func stopObserving() {
        notificationCenter.removeObserver(self, name: NSMenu.didAddItemNotification, object: nil)
        notificationCenter.removeObserver(self, name: NSMenu.didChangeItemNotification, object: nil)
        notificationCenter.removeObserver(self, name: NSMenu.didChangeItemNotification, object: nil)
    }
    
    /// Handle received notifications.
    @objc func received(notification: NSNotification) {
        let menu = notification.object as? NSMenu
//        let itemIndex = notification.userInfo?["NSMenuItemIndex"] as? Int ?? -1
//        let menuItem = menu?.item(at: itemIndex)
        
        if menu?.isChildOf(Const.Menu.main) ?? false {
            
            // Reload outlineView for superitem if needed.
            if ViewController.initialized != nil {
                self.cancelPreviousPerformRequiestsAndPerform(#selector(self.reloadOutlineViewItem(for:)), with: menu, afterDelay: 0.5)
            }
            
            // Provide debug info based on notification type
            switch notification.name {
            case NSMenu.didAddItemNotification:
//                inDebug { print("Did add menuItem: '\(menu?.title ?? "") -> \(menuItem?.title ?? "")' (index: \(itemIndex))") }
                break
            case NSMenu.didChangeItemNotification:
//                inDebug { print("Did change menuItem: '\(menu?.title ?? "") -> \(menuItem?.title ?? "")' (index: \(itemIndex))") }
                break
            case NSMenu.didRemoveItemNotification:
//                inDebug { print("Did remove menuItem from Menu '\(menu?.title ?? "")' at index \(itemIndex)") }
                break
            default:
                assertionFailure("Unexpected notification type.")
            }
        }
    }
    
    /// Reload ViewController's Outline View item for given menu if needed.
    @objc func reloadOutlineViewItem(for menu: NSMenu?) {
        if let superItem = menu?.superitem {
            ViewController.initialized?.outlineView.reloadItem(superItem, reloadChildren: true)
        }
    }
}
