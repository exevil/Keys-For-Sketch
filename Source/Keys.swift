//
//  Keys.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 11/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class Keys: NSObject {
    
    /// Shared instance
    @objc static var shared = Keys()
    /// `true` if plugin loading process is finished succesfuly.
    @objc var isLoaded: Bool = false
    
    // MARK: Properties
    
    /// Keys bundle shortcut.
    static var bundle: Bundle {
        return Bundle(for:Keys.self)
    }
    
    /// URL of `KeysForSketch.sketchplugin` bundle.
    static var pluginPath: String {
        let frameworkPath = bundle.bundleURL.path
        let endPathIndex = frameworkPath.range(of: ".sketchplugin", options: .backwards)!.upperBound
        let endPath = String(frameworkPath.prefix(upTo: endPathIndex))
        return endPath
    }
    
    // CFBundleShortVersionString shortcut.
    static var shortVersion: String {
        return bundle.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    // MARK: Start
    
    /// Plugin loading preparations.
    @objc class func start() {

        // Try to test API protocols and inject it to its Sketch classes for easier casting in Swift. If fails, Keys shouldn't run further
        do {
            try SketchAPIProtocolsTest.testProtocols()
            try SketchAPITools.injectAPIProtocols()
        } catch {
            NSAlert.showKeysErrorAlert(error: error)
            return
        }

        // Keys should start loading only after Sketch isFinishedLaunching
        if NSRunningApplication.current.isFinishedLaunching {
            shared.loadKeys()
        } else {
            NotificationCenter.default.addObserver(shared,
                                                   selector: #selector(shared.loadKeys),
                                                   name: NSApplication.didFinishLaunchingNotification,
                                                   object: NSApp)
        }
    }
    
    /// Load plugin.
    @objc func loadKeys() {
        do {
            try UIInjector.injectKeysPanel()
            // TODO: Don't forget to execute only after license verification.
//            try ProKeysManager.injectProKeys()
        } catch {
            NSAlert.showKeysErrorAlert(error: error)
        }
        
        
        // Invoke Observers
        MenuObserver.shared.startObserving()
        FileObserver.shared.startObserving()
        // TODO: Add license management
        
        // Update loading status
        isLoaded = true
    }
}
