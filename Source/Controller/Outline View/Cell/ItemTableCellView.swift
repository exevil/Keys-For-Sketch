//
//  KeyItemTableCellView.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 12/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class ItemTableCellView: NSTableCellView {
    
    @IBOutlet weak var shortcutView: ShortcutView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var menuButton: NSButton!
    
    // MARK: Init
    
    // Should be assigned during cell initialization process
    internal var menuItem: NSMenuItem! {
        didSet {
            shortcutView.menuItem = menuItem
            titleLabel.stringValue = menuItem.title
            // Hide shortcut view if now shortcut needed
            shortcutView.isHidden = !menuItem.needsShortcut
            // Hide menu button if there's no custom shortcut to manage
            menuButton.isHidden = !menuItem.hasCustomShortcut
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Draw fake separator
        self.layer = {
            let layer = CALayer()
            let separatorLayer = CAShapeLayer()
            separatorLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: Const.Cell.dividerHeight)
            separatorLayer.backgroundColor = NSColor(calibratedRed: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
            layer.addSublayer(separatorLayer)
            return layer
        }()
    }
    
    // MARK: Actions
    
    /// Popup context menu on button press.
    @IBAction func contextualMenuButtonAction(_ sender: NSButton) {
        let contextualMenu = ItemCellContextualMenu(menuItem: menuItem)
        contextualMenu.popUp(positioning: nil, at: NSPoint(x: sender.frame.minX, y: sender.frame.minY), in: self)
    }
    
    // MARK: Other
    
    /// Blink animation.
    func blink(with color: NSColor, forDuration duration: Float) {
        let transparentColor = NSColor(calibratedWhite: 1.0, alpha: 0.0).cgColor
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation.values = [color.cgColor, transparentColor]
        animation.keyTimes = [0.1, 1.0]
        animation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        ]
        animation.duration = CFTimeInterval(duration)
        
        layer?.add(animation, forKey: "animation")
    }
}
