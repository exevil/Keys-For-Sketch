//
//  ActionsMenu.swift
//  
//
//  Created by Vyacheslav Dubovitsky on 21/03/2017.
//
//

class ActionsMenu: NSMenu {
    
    /// Show warning alert and if its passed reset all shortcuts to default ones.
    @IBAction func resetButtonAction(_ sender: Any) {
        
        /// Action for "Yes" button.
        let yesAction: () -> Void = {
            // Remove all user shortcut data from System Preferences
            CFPreferencesSetAppValue(Const.Preferences.kUserKeyEquivalents, nil, kCFPreferencesCurrentApplication)
            CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
            // Clean local shortcut cache
            appKeyEquivalents.pointee = nil
            
            // Recursively update all Menu Items in main menu to apply default key equivalent values.
            Const.Menu.main.iterateAndExecute { $0._recacheUserKeyEquivalentOnlyIfStale(false) }
            // Reload Outline View if needed.
            ViewController.initialized?.outlineView.reloadData()
        }
        
        // Show confirmation alert
        
        let alertCompletionHandler = { (pressedButtonNumber: Int) in
            switch pressedButtonNumber {
            case 0:
                yesAction()
            default:
                break
            }
        }
        NSAlert.showAlert(over: ViewController.initialized?.view.window,
                          messageText: "Reset All Shortcuts?",
                          informativeText: "All Sketch user shortcuts including ones that defined manually in System Preferences will be immediately erased and default values will be restored.",
                          orderedButtonTitles: ["Yes", "No"],
                          completionHandler: alertCompletionHandler)
    }
    
    // ---

    @IBAction func proRegistrationInfoButtonAction(_ sender: Any) {
        LicensingWindowController.shared.showWindow(self)
    }
    
    // ---
    
    @IBAction func reportIssueButtonAction(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/exevil/Keys-For-Sketch/issues")!)
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/exevil/Keys-For-Sketch/blob/master/README.md#faq")!)
    }
    
    @IBAction func supportButtonAction(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.paypal.me/exevil/10d")!)
    }
}
