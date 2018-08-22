//
//  UIInjector.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 15/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class UIInjector: NSObject {
    
    /// Shared instance of MSPreferencesController.
    @objc static let pc = VDKSketchAPI.preferencesController()
    
    /// Add Keys Panel to Sketch Preferences.
    class func injectKeysPanel() throws {
        pc.loadWindow()
        
        // Make sure that all used properties are exists.
        guard let toolbar = pc.toolbar else {
            throw Error.prefsControllerPropertyIsNil(propertyKeyPath: #keyPath(pc.toolbar))
        }
        guard var toolbarItemIdentifiers = pc.toolbarItemIdentifiers else {
            throw Error.prefsControllerPropertyIsNil(propertyKeyPath: #keyPath(pc.toolbarItemIdentifiers))
        }
        
        // Register and insert Keys toolbar item into Preferences window toolbar.
        pc.preferencePaneClasses[Const.Preferences.keysIdentifier] = ViewController.self
        
        toolbarItemIdentifiers.append(Const.Preferences.keysIdentifier)
        pc.toolbarItemIdentifiers = toolbarItemIdentifiers
        
        toolbar.insertItem(withItemIdentifier: Const.Preferences.keysIdentifier, at: toolbar.items.count)
        
        // Make sure that last closed tab is selected again
        if pc.toolbar?.selectedItemIdentifier == nil {
            pc.switchToPane(withIdentifier: toolbarItemIdentifiers[Int(pc.selectedTabIndex)])
        }
        
        // Hide Preferences window.
        pc.close()
    }

    enum Error: LocalizedError {
        
        case prefsControllerPropertyIsNil(propertyKeyPath: String)
        
        var errorDescription: String? {
            switch self {
            case .prefsControllerPropertyIsNil(let propertyKeyPath):
                return "MSPreferencesController property \"\(propertyKeyPath)\" is unexpectedly nil."
            }
        }
    }
}
