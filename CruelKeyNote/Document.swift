//
//  Document.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Cocoa
import Foundation

class Document: NSPersistentDocument {
    @IBOutlet weak var daysController: CKNTimeArrayController!
    @IBOutlet weak var eventsController: NSArrayController!
   
    /*
    func windowDidBecomeKey(notification:NSNotification)
    {
        hudPanelController.doc = self
        if hudPanelController.daysTable != nil {
            hudPanelController.daysTable!.reloadData()
        }
        print("windowDidBecameKey \(self)\(hudPanelController)")

    }
    func windowDidResignKey(notification:NSNotification) {
        hudPanelController.doc = nil
        
    if hudPanelController.daysTable != nil {
            hudPanelController.daysTable!.reloadData()
        }
        print("windowDidResignKey: \(self)\(hudPanelController)")

    }
        */
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        //print("Panel \(self.managedObjectContext)")
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }


}
