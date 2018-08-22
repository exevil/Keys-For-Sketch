//
//  LicensingWindowController.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 23/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Cocoa

class LicensingWindowController: NSWindowController {
    
    // MARK: Properties
    
    static let shared = LicensingWindowController(windowNibName: NSNib.Name(rawValue: "LicensingWindowController"
    ))
    
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var serialTextField: NSTextField!
    @IBOutlet weak var activateButton: NSButton!
    
    // MARK: Loading
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Initial setup
        window?.backgroundColor = NSColor(calibratedHue: 0, saturation: 0, brightness: 98.0/100.0, alpha: 1)
        window?.styleMask.remove(.resizable)
        window?.isMovableByWindowBackground = true
        
        // Hide title bar
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.styleMask.insert(.fullSizeContentView)
        
        // Hide excessive buttons
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window?.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    // Actions
}
