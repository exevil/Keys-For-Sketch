//
//  Constants.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 19/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public struct Const {
    /// Image names.
    public struct Image {
        public static let keysIcon = "KeysIcon.icns"
        static let disclosureVertiacal = "disclosure-vertical"
        static let disclosureHorizontal = "disclosure-horizontal"
    }
    
    struct Menu {
        
        /// Sketch's mainMenu.
        static let main = NSApplication.shared.mainMenu!
        
        /// A dictionary where keys is titles of Tool Menu Items and the objects is a Sketch action class names associated with it.
        static let toolsClassNames = [
            "Vector" : "MSInsertVectorAction",
            "Pencil" : "MSPencilAction",
            "Text" : "MSInsertTextLayerAction",
            "Artboard" : "MSInsertArtboardAction",
            "Slice" : "MSInsertSliceAction",
            // Shape Submenu items
            "Line" : "MSInsertLineAction",
            "Arrow" : "MSInsertArrowAction",
            "Rectangle" : "MSRectangleShapeAction",
            "Oval" : "MSOvalShapeAction",
            "Rounded" : "MSRoundedRectangleShapeAction",
            "Star" : "MSStarShapeAction",
            "Polygon" : "MSPolygonShapeAction",
            "Triangle": "MSTriangleShapeAction"
        ]
    }
    
    struct MenuItem {
        /// An array of manually defined tuples describing a menuItems that shouldn't be customized by Keys.
        static let customizableShortcutExceptions: [(title: String, parentItem: String)] = [
        // Sketch
            // Dynamic system menu. Better to manage through System Preferences
            ("Services", Const.Menu.main.items[0].title),
        // File
            // A group of dynamic items
            ("New from Template", "File"),
            // Hidden by Sketch from the main menu
            ("New from Template…", "File"),
            // A group of dynamic items
            ("Open Recent", "File"),
            // A group of dynamic items
            ("Revert To", "File"),
            // A group of dynamic items
            ("Print", "File"),
        // Edit
            // Since "Start Dictation" has`fn fn` shortcut by default which we cant easily reassign, skip it too.
            ("Start Dictation", "Edit"),
        // Insert
        // Layer
            // A group of dynamic items
            ("Replace With", "Layer")
        // Text
        // Arrange
        // Share
        // Plugins
        // View
        // Window
        // Help
        ]
    }
    
    struct Cell {
        // OutlineView cells
        static let height: CGFloat = 33.0
        static let separatorHeight: CGFloat = 8.0
        static let dividerHeight: CGFloat = 0.5
    }
    
    struct KeyCodeTransformer {
        /// A map of non-printed characters Key Codes to its String representations. Values presented in array to match KeyCodeTransformer mapping dictionary data representation.
        static let specialKeyCodesMap : [UInt : [String]] = [
            UInt(kVK_F1) : [String(unicodeInt: NSF1FunctionKey)],
            UInt(kVK_F2) : [String(unicodeInt: NSF2FunctionKey)],
            UInt(kVK_F3) : [String(unicodeInt: NSF3FunctionKey)],
            UInt(kVK_F4) : [String(unicodeInt: NSF4FunctionKey)],
            UInt(kVK_F5) : [String(unicodeInt: NSF5FunctionKey)],
            UInt(kVK_F6) : [String(unicodeInt: NSF6FunctionKey)],
            UInt(kVK_F7) : [String(unicodeInt: NSF7FunctionKey)],
            UInt(kVK_F8) : [String(unicodeInt: NSF8FunctionKey)],
            UInt(kVK_F9) : [String(unicodeInt: NSF9FunctionKey)],
            UInt(kVK_F10) : [String(unicodeInt: NSF10FunctionKey)],
            UInt(kVK_F11) : [String(unicodeInt: NSF11FunctionKey)],
            UInt(kVK_F12) : [String(unicodeInt: NSF12FunctionKey)],
            UInt(kVK_F13) : [String(unicodeInt: NSF13FunctionKey)],
            UInt(kVK_F14) : [String(unicodeInt: NSF14FunctionKey)],
            UInt(kVK_F15) : [String(unicodeInt: NSF15FunctionKey)],
            UInt(kVK_F16) : [String(unicodeInt: NSF16FunctionKey)],
            UInt(kVK_F17) : [String(unicodeInt: NSF17FunctionKey)],
            UInt(kVK_F18) : [String(unicodeInt: NSF18FunctionKey)],
            UInt(kVK_F19) : [String(unicodeInt: NSF19FunctionKey)],
            UInt(kVK_F20) : [String(unicodeInt: NSF20FunctionKey)],
            UInt(kVK_Space) : ["\u{20}"],
            UInt(kVK_Delete) : [String(unicodeInt: NSBackspaceCharacter)],
            UInt(kVK_ForwardDelete) : [String(unicodeInt: NSDeleteCharacter)],
            UInt(kVK_ANSI_KeypadClear) : [String(unicodeInt: NSClearLineFunctionKey)],
            UInt(kVK_LeftArrow) : [String(unicodeInt: NSLeftArrowFunctionKey), "\u{2190}"],
            UInt(kVK_RightArrow) : [String(unicodeInt: NSRightArrowFunctionKey), "\u{2192}"],
            UInt(kVK_UpArrow) : [String(unicodeInt: NSUpArrowFunctionKey), "\u{2191}"],
            UInt(kVK_DownArrow) : [String(unicodeInt: NSDownArrowFunctionKey), "\u{2193}"],
            UInt(kVK_End) : [String(unicodeInt: NSEndFunctionKey)],
            UInt(kVK_Home) : [String(unicodeInt: NSHomeFunctionKey)],
            UInt(kVK_Escape) : ["\u{1b}"],
            UInt(kVK_PageDown) : [String(unicodeInt: NSPageDownFunctionKey)],
            UInt(kVK_PageUp) : [String(unicodeInt: NSPageUpFunctionKey)],
            UInt(kVK_Return) : [String(unicodeInt: NSCarriageReturnCharacter)],
            UInt(kVK_ANSI_KeypadEnter) : [String(unicodeInt: NSEnterCharacter)],
            UInt(kVK_Tab) : [String(unicodeInt: NSTabCharacter)],
            UInt(kVK_Help) : [String(unicodeInt: NSHelpFunctionKey)],
            UInt(kVK_Function) : ["\u{F747}"]
        ]
    }
    
    struct Preferences {
        // Identifier used to present Keys in Preferences window.
        static let keysIdentifier = NSToolbarItem.Identifier(rawValue: "keysForSketch")
        // Keys used to store settings in Preferences
        static let kUserKeyEquivalents = "NSUserKeyEquivalents" as CFString
        static let kCustomMenuApps = "com.apple.custommenu.apps" as CFString
        static let kUniversalAccess = "com.apple.universalaccess" as CFString
    }
    
    struct Licensing {
        /// Key for local storing of Licensing Info in UserDefaults.
        static let kLicensingInfoDefaultsDict = "VDKLicensingInfo"
    }
}

fileprivate extension String {
    /// Init with unicode int value.
    init(unicodeInt: Int) {
        self = String(format: "%C", unicodeInt)
    }
}
