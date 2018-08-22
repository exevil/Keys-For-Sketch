//
//  LicensingInfoTextFieldCell.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 27/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Cocoa

class LicensingInfoTextFieldCell: NSTextFieldCell {
    
    override func awakeFromNib() {
        bezelStyle = .roundedBezel
        focusRingType = .none
    }
    
    // Center text vert
    override func drawingRect(forBounds rect: NSRect) -> NSRect {
        let horizontalInset: CGFloat = -6 // For better appearance
        let textHeight: CGFloat = 24 // Default text height.
        let newRect = NSRect(x: horizontalInset,
                             y: (rect.size.height - textHeight) / 2,
                             width: rect.size.width - horizontalInset,
                             height: textHeight)
        return super.drawingRect(forBounds: newRect)
    }
    
}
