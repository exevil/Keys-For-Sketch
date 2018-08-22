//
//  DonationButton.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 04/03/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

class DonationButton: NSButton {

    override func awakeFromNib() {
        // Button Styling
        let paragraphStyle: NSParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            return style
        }()
        var basicAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : font!,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        attributedTitle = NSAttributedString(string: title, attributes:{
           basicAttributes[.foregroundColor] = NSColor(calibratedRed: 74/255, green: 144/255, blue: 226/255, alpha: 1)
            return basicAttributes
        }())
        
        attributedAlternateTitle = NSAttributedString(string: title, attributes:{
            basicAttributes[.foregroundColor] = NSColor(calibratedRed: 74/255, green: 144/255, blue: 226/255, alpha: 0.5)
            return basicAttributes
        }())
    }
    
}
