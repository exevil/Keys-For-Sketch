//
//  ShortcutView.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 19/02/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class ShortcutView: MASShortcutView {
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        style = MASShortcutViewStyleFlat
        shortcutValidator = ShortcutValidator.shared()
    }
    
    var errorHandler = ShortcutErrorHandler.shared
    // Should be set right after cell initialization
    var menuItem: NSMenuItem! {
        didSet {
            shortcutValue = menuItem.shortcut
        }
    }
    
    // Override shortcut cell class to customize appearance
    override public class func shortcutCellClass() -> Swift.AnyClass! {
        return ShortcutButtonCell.self
    }
    
    // MARK: Mouse actions
    
    // Disable right hinting buttons provided by default implementation of MASShortcutView
    override public func mouseDown(with event: NSEvent) {
        if isEnabled {
            isRecording = !isRecording
        } else {
            super.mouseDown(with: event)
        }
    }
    
    // Disable default hints by hover on hinting buttons
    override public func mouseEntered(with event: NSEvent) {}
    override public func mouseExited(with event: NSEvent) {}
    
    // MARK: activateEventMonitoring:
    // This private method of MASShortcutView handles first level shortcut approval when user set it in ShortcutView. See this and original implementation for details
    
    var eventMonitoringIsActive: Bool = false {
        willSet {
            if eventMonitoringIsActive != newValue {
                // Convert to NSNumber to pass Bool to performSelector
                let numberValue = NSNumber(booleanLiteral: newValue)
                perform(NSSelectorFromString("activateResignObserver:"), with: numberValue)
                perform(NSSelectorFromString("activateEventMonitoring:"), with: numberValue)
            }
        }
    }
    
    var eventMonitor: Any?
    
    // `override` attribute didn't used since original method is private
    @objc public func activateEventMonitoring(_ shouldActivate: NSNumber) {
        
        if shouldActivate.boolValue {
            let eventMask = NSEvent.EventTypeMask.keyDown.rawValue | NSEvent.EventTypeMask.flagsChanged.rawValue
            eventMonitor = NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask(rawValue: eventMask), handler: {(inputEvent) -> NSEvent? in
                
                var event:NSEvent? = inputEvent
                
                // Create a shortcut from the event
                let shortcut = MASShortcut(event: event)!
                let keyCode = shortcut.keyCode
                let modifierFlags = shortcut.modifierFlags
                
                // Tab & Space keys must pass through
                if  keyCode.isEqual(toValueOf: [kVK_Tab, kVK_Space]) {
                    return event;
                }
                
                // If the shortcut is a plain Delete or Backspace, clear the current shortcut and cancel recording
                if modifierFlags == 0 && keyCode.isEqual(toValueOf: [kVK_Delete, kVK_ForwardDelete]) {
                    self.shortcutValue = nil;
                    self.isRecording = false;
                    event = nil;
                    // If error sheet is presented end it
                    self.errorHandler.endErrorSheetIfDisplayed()
                }
                    
                else if modifierFlags == 0 && keyCode.isEqual(toValueOf: [kVK_Escape, kVK_Return, kVK_ANSI_KeypadEnter]) {
                    // If error alert already shown use keys to control it
                    if self.errorHandler.presentedErrorSheet != nil {
                        return event
                    }
                    // If not just cancel recording
                    self.isRecording = false;
                    event = nil;
                }
                    
                // If the shortcut is Cmd-W or Cmd-Q, cancel recording and pass the event through
                else if modifierFlags == NSEvent.ModifierFlags.command.rawValue && keyCode.isEqual(toValueOf: [kVK_ANSI_W, kVK_ANSI_Q]) {
                    self.isRecording = false;
                }
                    
                else {
                    // Verify possible shortcut
                    if shortcut.keyCodeString.count > 0 {
                        if (self.shortcutValidator as! ShortcutValidator).isShortcutValid(shortcut, validWithoutModifiers: self.menuItem.isTool) {
                            
                            // Prevent cancel of recording when Alert window is key (part 1)
                            self.eventMonitoringIsActive = false
                            
                            // If shortcut is used somwhere else on the system, begin shortcut error sheet 
                            var explanation: NSString? = nil
                            if self.shortcutValidator.isShortcutAlreadyTaken(bySystem: shortcut, explanation:&explanation), shortcut != self.shortcutValue {
                                self.errorHandler.beginErrorSheet(with: shortcut, explanation: explanation! as String, sender: self)
                                self.perform(NSSelectorFromString("setShortcutPlaceholder:"), with: nil)
                                
                                // Prevent cancel of recording when Alert window is key (part 2)
                                self.eventMonitoringIsActive = true
                            }
                            else {
                                // Shortcut is valid, assign it
                                self.menuItem.shortcut = shortcut
                                self.isRecording = false
                            }
                        }
                        else {
                            // Key press with or without SHIFT is not valid input
                            __NSBeep();
                        }
                    }
                    else {
                        // User is playing with modifier keys
                        self.perform(NSSelectorFromString("setShortcutPlaceholder:"), with:shortcut.modifierFlagsString)
                    }
                    event = nil;
                }
                return event;
            })
        } else {
            // !shouldActive: Disable event monitoring
            if eventMonitor != nil {
                NSEvent.removeMonitor(eventMonitor!)
            }
        }
    }
}

extension UInt {
    /// Compare each value of given array to self.
    /// - parameter array: An array of integers to compare with self.
    /// - returns: true if one or more of given values are equal to self.
    func isEqual(toValueOf array: [Int]) -> Bool {
        for int in array {
            if self == UInt(int) { return true }
        }
        
        return false
    }
}
