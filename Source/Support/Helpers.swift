//
//  Helpers.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 06/07/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

/// Execute given closure in `#DEBUG` configuration.
func inDebug(_ closure: () -> () ) {
    #if DEBUG
        closure()
    #endif
}

// MARK: Assertions

/// Fast `non-nil` assert.
func assertNonNil(_ object: AnyObject?) {
    assert(object != nil, "Object is nil.")
}

/// Fast `respondsToSelector` assert.
func assert(_ object: AnyObject, respondsTo selector: Selector) {
    assert(object.responds(to: selector), "Object is not responding to selector.")
}

/// Get a resource from asset catalog by name
public func image(_ imageName: String) -> NSImage? {
    return Bundle(for:Keys.self).image(forResource: NSImage.Name(rawValue: imageName))
}

// MARK: Other

/// Pointer to internal static AppKit dictionary with cached user Key Equivalents.
let appKeyEquivalents: UnsafeMutablePointer<NSDictionary?> = {
    let addr = UInt(lorgnette_lookup(mach_task_self_, "sAppKeyEquivalents"))
    return UnsafeMutablePointer<NSDictionary?>(bitPattern:addr)!
}()

