//
//  FileObserver.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 29/06/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

// FileObserver observes changes made in plugin file. If user or Sketch modifying it (on update or reinstall, for instance) an alert asking to Restart Sketch should appear.
public class FileObserver: NSObject {
    
    @objc public static let shared = FileObserver()
    /// https://github.com/soh335/FileWatch
    var fileWatch: FileWatch?
    
    @objc public func startObserving() {
        fileWatch = try! FileWatch(paths: [Keys.pluginPath],
                                   createFlag: [.UseCFTypes, .FileEvents],
                                   runLoop: RunLoop.current,
                                   latency: 0.5,
                                   eventHandler: { event in
                                    
                                    inDebug {
                                        print("""
                                        
                                        \(event.path)
                                        
                                        == pluginURL: \(event.path == Keys.pluginPath)
                                        .ItemCreated: \(event.flag.contains(.ItemCreated))
                                        .ItemRemoved: \(event.flag.contains(.ItemRemoved))
                                        .ItemInodeMetaMod: \(event.flag.contains(.ItemInodeMetaMod))
                                        .ItemRenamed: \(event.flag.contains(.ItemRenamed))
                                        .ItemModified: \(event.flag.contains(.ItemModified))
                                        .ItemFinderInfoMod: \(event.flag.contains(.ItemFinderInfoMod))
                                        .ItemChangeOwner: \(event.flag.contains(.ItemChangeOwner))
                                        .ItemXattrMod: \(event.flag.contains(.ItemXattrMod))
                                        
                                        """)
                                    }
                                    
                                    if
                                        event.flag.contains(.ItemModified) // Manual Plugin Installation
                                        || event.path == Keys.pluginPath && event.flag.contains(.ItemRenamed) // Automatic update by Sketch
                                        
                                    {
                                        // Most of changes should appear through latency period but to make sure that all files passed, delay displaying of update alert until all files will be copied.
                                        self.cancelPreviousPerformRequiestsAndPerform(#selector(self.fileChanged), with: nil, afterDelay: 0.75)
                                    }
        })
    }
    
    @objc func fileChanged() {
        let alert = UpdateCompletionAlert()
        alert.completionHandler(with: alert.runModal())
    }
}

extension NSObject {
    /// Cancel previous perform requests with given arguments for object and register new one
    /// - note: Useful when you need to run a selector after a bunch of repetitive actions. Each action should cancel previous perform request and register a new delayed request afterwards. Selector will perform after the last action registers its perform request and its delay time will expire.
    func cancelPreviousPerformRequiestsAndPerform(_ aSelector: Selector, with anArgument: Any?, afterDelay delay: TimeInterval) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: aSelector, object: anArgument)
        self.perform(aSelector, with: anArgument, afterDelay: delay)
    }
}
