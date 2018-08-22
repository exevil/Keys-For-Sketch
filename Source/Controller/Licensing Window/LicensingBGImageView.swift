//
//  LicensingBGImageView.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 28/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Cocoa

class LicensingBGImageView: NSImageView {
    
    // Pass mouse events to superview to allow moving window by dragging it anywhere
    override var mouseDownCanMoveWindow: Bool {
        return true
    }
    
}
