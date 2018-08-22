//
//  ViewController.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 12/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class ViewController: NSViewController {
    
    /// - important: Should return instance only after plugin initialization.
    static var initialized: ViewController? 
    
    // MARK: Sketch's MSPreferencePane conformation
    
    @objc static var toolbarIcon = image(Const.Image.keysIcon)
    @objc static var title = "Keys"
    @objc static var identifier = Const.Preferences.keysIdentifier
    @objc static var nibName = NSNib.Name(rawValue: "ViewController")
    @objc var preferencesController: AnyObject?
    
    @objc public convenience init(preferencesController: AnyObject) {
        self.init(nibName: type(of: self).nibName, bundle: Keys.bundle)
        self.preferencesController = preferencesController
        ViewController.initialized = self
    }
    
    // MARK: Variables
    
    @IBOutlet weak var outlineScrollView: NSScrollView!
    @IBOutlet weak var outlineView: OutlineView!
    @IBOutlet weak var actionMenu: ActionsMenu!
    
    // MARK: Actions
    
    // Main Settings button action
    @IBAction func settingsButtonAction(_ sender: NSButton) {
        actionMenu.popUp(positioning: nil, at: NSPoint(x: sender.frame.minX, y: sender.frame.minY), in: view)
    }
    
    // MARK: View Preparations
    
    override public func viewWillAppear() {
        // Style Outline View
        outlineScrollView.layer = {
            let layer = CALayer()
            layer.borderWidth = 0.5
            layer.borderColor = NSColor.lightGray.cgColor
            return layer
        }()
    }
}
