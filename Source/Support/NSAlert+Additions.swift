//
//  NSAlert+additions.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 09/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

extension NSAlert {
    /**
     Display an alert sheet with given parameters and execute closure associated with pressed button. Buttons will shown on `NSAlert` in the same order in order that provides orderedButtonTitles array
     
     - parameters:
         - window: An NSWindow instance new sheet should be attached to. While nil value is passed method will firstly try to attach alert to NSApplication's mainWindow but if it's nil too alert will be shown separately using `runModal()` method.
         - style: 'NSAlert''s alertSytle.
         - icon: 'NSAlert''s icon.
         - messageText: `NSAlert's` messageText.
         - informativeText: `NSAlert's` informativeText.
         - orderedButtonTitles: Titles of alert buttons ordered from first to last one.
         - completionHandler: Closure with pressed button number as a parameter. Button number should correspond the button order in `orderedButtonTitles` parameter's array.
     */
    class func showAlert(over window: NSWindow? = nil,
                         style: NSAlert.Style = .informational,
                         icon: NSImage? = image(Const.Image.keysIcon),
                         messageText: String,
                         informativeText: String,
                         orderedButtonTitles: [String],
                         completionHandler: ((_ pressedButtonNumber: Int) -> Void)?
        ) {
        
        // Make alert
        let alert = NSAlert()
        alert.alertStyle = style
        alert.icon = icon ?? alert.icon
        alert.messageText = messageText
        alert.informativeText = informativeText
        orderedButtonTitles.forEach {
            alert.addButton(withTitle: $0)
        }
        
        // Handle completion handler
        let alertCompletionHandler: (NSApplication.ModalResponse) -> () = { response in
            // Responeded buttons have incremental (by 1) indexes started from 1000
            let buttonNumber = response.rawValue - 1000
            completionHandler?(buttonNumber)
        }
    
        // Attach to window if possible and needed
        if let win = window {
            alert.beginSheetModal(for: win, completionHandler: alertCompletionHandler)
        } else {
            alertCompletionHandler(alert.runModal())
        }
    }
    
    /**
     `showAlert` method shorthand for quick presentation of error `localizedDescription` as part of message text.
     
     - important: Descriptions of other parameters can be found in `showAlert` method.
     
     - parameters:
         - error: Error instance which `localizedDescription` should be used in alert.
         - underErrorText: Additional text that should be placed right after an error message.
     */
    class func showKeysErrorAlert(over window: NSWindow? = nil,
                                        style: NSAlert.Style = NSAlert.Style.critical,
                                        icon: NSImage? = image(Const.Image.keysIcon),
                                        messageText: String = "Keys For Sketch Error Occurred",
                                        error: Error,
                                        underErrorText: String = "Make sure you running latest versions of Keys and Sketch and contact developer if problem still occurs.",
                                        orderedButtonTitles: [String] = ["OK"],
                                        completionHandler: ((_ pressedButtonNumber: Int) -> Void)? = nil) {
        
        showAlert(over: window,
                  style: style,
                  icon: icon,
                  messageText: messageText,
                  informativeText: "\(error.localizedDescription)\n· · ·\n\(underErrorText)",
                  orderedButtonTitles: orderedButtonTitles,
                  completionHandler: completionHandler)
    }
}
