//
//  ProKeyAspectRatioSwitcher.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 31/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

/// Aspect ratio (Constrain Proportions) lock switching menu item.
final class ProKeyAspectRatioSwitcher: NSObject, ProKeyProtocol {

    static let shared: ProKeyProtocol = ProKeyAspectRatioSwitcher()
    
    let menuItems: [NSMenuItem]
    let parentMenu: NSMenu? = Const.Menu.main.item(withTitle: "Layer")?.submenu?.item(withTitle: "Transform")?.submenu
    let previousMenuItemTitle: String? = "Rotate"
    
    /// Button for switching aspect ratio lock in Sketch Inspector which our menu should correspond to.
    var sketchInspectorButton: NSButton? {
        return VDKSketchAPI.currentDocument()?.inspectorController.normalInspector.standardInspectors.layerViewController.lockProportionsButton
    }
    
    override init() {
        let actionMenuItem = NSMenuItem(title: "Constrain Proportions", action: #selector(action), keyEquivalent: "")
        menuItems = [
            NSMenuItem.separator(),
            actionMenuItem,
            NSMenuItem.separator()
        ]
        super.init()
        actionMenuItem.target = self
    }
    
    /// Simply click on Sketch Inspector button.
    @objc func action() {
        if let inspectorButton = sketchInspectorButton {
            inspectorButton.performClick(self)
        }
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if let inspectorButton = sketchInspectorButton {
            menuItem.state = inspectorButton.state
            return inspectorButton.isEnabled
        } else {
            menuItem.state = .off
            return false
        }
    }
}
