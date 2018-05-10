//
//  Document.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Cocoa
import Foundation

//@objc(Document)

class Document: NSPersistentDocument {
    @IBOutlet weak var daysController: CKNDaysController!
    @IBOutlet weak var eventsController: CKNEventsController!
   
    

     class func autosavesInPlace() -> Bool {
        return true
    }

     override var windowNibName: NSNib.Name? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return NSNib.Name(rawValue: "Document")
    }
    
    
    
}
