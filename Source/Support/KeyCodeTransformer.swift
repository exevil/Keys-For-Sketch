//
//  KeyCodeTransformer.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 13/05/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class KeyCodeTransformer: NSObject {
    
    static let shared = KeyCodeTransformer()
    
    /// Array of currently enabled keyboard layouts.
    /// - important: First array item should always represent the Current ASCII Capable Keyboard Layout Input Source.
    private static let userKeyboardLayouts: [UnsafePointer<UCKeyboardLayout>] = {
        // Get filtered input sources array
        let options = NSMutableDictionary()
        options.setObject(kTISCategoryKeyboardInputSource, forKey: kTISPropertyInputSourceCategory as NSString)
        options.setObject(true, forKey: kTISPropertyInputSourceIsEnabled as NSString)
        var inputSources = TISCreateInputSourceList(options as CFDictionary, false).takeRetainedValue() as! [TISInputSource]
        
        // Get current ASCII keyboard layout name to place it at first index by sorting the Input Sources array.
        let currentASCIIKeyboardName = TISGetInputSourceProperty(TISCopyCurrentASCIICapableKeyboardLayoutInputSource().takeRetainedValue(), kTISPropertyLocalizedName)
        
        guard let currentKBIndex = inputSources.index(where:{
            let localizedName = TISGetInputSourceProperty($0, kTISPropertyLocalizedName)
            return localizedName == currentASCIIKeyboardName
        }) else {
            fatalError("Can't find current Keyboard index in inputSources array.")
        }
        
        inputSources.swapAt(currentKBIndex, inputSources.startIndex)
        
        // Transform TISInputSource to UnsafePointer<UCKeyboardLayout> which is required by UCKeyTranslate
        var layouts = [UnsafePointer<UCKeyboardLayout>]()
        inputSources.forEach {
            if let rawLayoutData = TISGetInputSourceProperty($0, kTISPropertyUnicodeKeyLayoutData) {
                let layoutData = Unmanaged<CFData>.fromOpaque(rawLayoutData).takeUnretainedValue() as Data
                layoutData.withUnsafeBytes {
                    layouts.append($0)
                }
            }
        }
        return layouts
    }()
    
    // MARK: Maps
    
    /// Dictionary that contains KeyCode to its Key Equivalent values mapping for standart ANSI keyboard.
    static let keyCodeToKeyEquivalentsMap: [UInt : [String]] = makeKeyCodeToKeyEquivalentsMap()
    /// Dictionary that contains KeyCode to its Key Equivalent values with Shift modifier used mapping for standart ANSI keyboard.
    static let keyCodeToKeyEquivalentsWithShiftMap: [UInt : [String]] = makeKeyCodeToKeyEquivalentsMap(using: shiftKey)
    
    /// Generate keyCode to its Key Equivalents array map
    /// - parameter modifiers: A modifiers used to generate Key Equivalents in Carbon key format. Default value is 0.
    private static func makeKeyCodeToKeyEquivalentsMap(using modifiers: Int = 0) -> [UInt : [String]] {
        // Add manually created special keys map to the generated one to complete collection.
        var resultDict = Const.KeyCodeTransformer.specialKeyCodesMap
        for keyCode in 0...127 {
            let keyCode = UInt(keyCode)
            if let keyEquivalents = keyEquivalents(for: keyCode, using: modifiers) {
                resultDict[keyCode] = keyEquivalents
            }
        }
        
        return resultDict
    }
    
    // MARK: Main Methods
    
    /// Get an array of Key Equivalents for given Key Code.
    /// - parameter keyCode: An integer that represents Key Code.
    /// - parameter modifiers: A modifiers used to generate Key Equivalents in Carbon key format. Default value is 0.
    /// - returns: Array of key equivalents that represents given Key Code for all installed Keyboard Layouts. Original ASCII glyphs should be placed at at the beginning of an array.
    class func keyEquivalents(for keyCode: UInt, using modifiers: Int = 0) -> [String]? {
        
        // Can be -1 when empty
        if Int(keyCode) < 0 { return nil }
        
        // If provided KeyCode indicates non-printable special key, return associated const value.
        if let specialKey = Const.KeyCodeTransformer.specialKeyCodesMap[keyCode] {
            return specialKey
        }
        
        // Iterate through layouts to find key equivalents for given Key Code
        var foundKeyEquivalents = [String]()
        for layout in userKeyboardLayouts {
            
            // Magic stuff
            let keyaction           = UInt16(kUCKeyActionDisplay)
            let modifierKeyState    = UInt32(modifiers >> 8) // Shift modifiers value right for 8 bits to suite UCKeyTranslate weirdo requirments
            let keyboardType        = UInt32(LMGetKbdType())
            let keyTranslateOptions = OptionBits(kUCKeyTranslateNoDeadKeysBit)
            var deadKeyState        = UInt32(0) // Is 0 the correct value?
            let maxStringLength     = 4
            var chars: [UniChar]    = [0]
            var actualStringLength  = 1
            let result = UCKeyTranslate(layout, UInt16(keyCode), keyaction, modifierKeyState, keyboardType, keyTranslateOptions,
                                        &deadKeyState, maxStringLength, &actualStringLength, &chars)
            
            // Continue to next layout if error acquired
            if result != noErr { continue }
            if let resultChar = UnicodeScalar(chars[0])?.description, resultChar != "\0" /* <- Default value */ {
                foundKeyEquivalents.append(resultChar)
            }
        }
        
        // Filter duplicated Key Equivalents and keep only unique ones
        var uniqueKeyEquivalents = [String]()
        foundKeyEquivalents.forEach {
            if !uniqueKeyEquivalents.contains($0) {
                uniqueKeyEquivalents.append($0)
            }
        }

        return uniqueKeyEquivalents.isEmpty ? nil : uniqueKeyEquivalents
    }
    
    /**
     Get Key Code for given Key Equivalent
     - parameter keyEquivalent: String. Should contain only one ANSI character.
     - returns: Tuple with following contents:
         - value: Integer that represent keyCode value for given Key Equivalent.
         - wasShiftKeyUsed: Bool that indicates if Shift key was used during set of given keyEquivalent.
    */
    class func keyCode(for keyEquivalent: String) -> (value: UInt, wasShiftKeyUsed: Bool)? {
        // Search in regular map
        for (key, values) in keyCodeToKeyEquivalentsMap {
            for value in values where value == keyEquivalent {
                return (key, false)
            }
        }
        // Search in map of Shifted keyEquivalents
        for (key, values) in keyCodeToKeyEquivalentsWithShiftMap {
            for value in values where value == keyEquivalent {
                return (key, true)
            }
        }
        
        return nil
    }
}
