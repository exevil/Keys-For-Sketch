//
//  ProKeyProtocol.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 30/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

protocol ProKeyProtocol {
    
    /// Shared instance.
    static var shared: ProKeyProtocol { get }
    
    /// Associated menu items that will be injected into Sketch menu.
    var menuItems: [NSMenuItem] { get }
    
    /// Sketch menu where ProKey's menu items should be placed.
    /// - note: Since there's no guarantee that given menu exists, value type is set to optional and should be implicitly unwrapped during ProKeys injection process.
    /// - important: If no item will be found, error will be thrown.
    var parentMenu: NSMenu? { get }
    
    /// Title of Sketch menu item placed in parent menu after which ProKey menu items should be placed after.
    /// - important: Make sure that entered title is correct and refers to existing Sketch menu item. Otherwise, error will be thrown during ProKeys injection process.
    var previousMenuItemTitle: String? { get }
    
    /// Menu item validation. See `NSMenuValidation` for help.
    /// - important: Make sure that menuItem's target set to self during initialization to get `NSMenuValidation` work.
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool
}

