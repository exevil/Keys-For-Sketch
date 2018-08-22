//
//  SearchField.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 13/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

import Cocoa

class SearchField: NSSearchField {
    
    @IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var outlineViewDataSource: OutlineViewDataSource!
    
    /// Send search phrase to Data source of Outline view and reload its data to show the results
    @IBAction func filterResults(_ sender: NSSearchFieldCell) {
        outlineViewDataSource.searchPhrase = sender.stringValue
        outlineView.reloadData()
        
        // Expand items when searching or collapse it back on searching ends
        if !sender.stringValue.isEmpty {
            outlineView.expandItem(nil, expandChildren: true)
        } else {
            outlineView.collapseItem(nil, collapseChildren: true)
        }
    }
}
