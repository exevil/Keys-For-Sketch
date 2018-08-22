//
//  UpdateCompleteAlert.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 19/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class UpdateCompletionAlert: NSAlert {
    
    override init() {
        super.init()
        messageText = "Keys Were Installed Sucessfully"
        informativeText = "Please restart Sketch to finish the instalation process."
        icon = image(Const.Image.keysIcon)
        
        addButton(withTitle: "Restart Sketch")
        addButton(withTitle: "Later")
    }
    
    /// Default completion handler for alert.
    @objc public func completionHandler(with response: NSApplication.ModalResponse) {
        if response == .alertFirstButtonReturn {
            // Relaunch Sketch
            let task = Process()
            task.launchPath = "/bin/sh"
            task.arguments = ["-c", "sleep \(0.5); open \"\(Bundle.main.bundlePath)\""]
            task.launch()
            NSApp.terminate(nil)
        }
    }

}
