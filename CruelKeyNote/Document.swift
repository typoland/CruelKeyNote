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
   
    
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
   
    
    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        //print("Panel \(self.managedObjectContext)")
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
       
       // let delegate:AppDelegate = NSApplication.sharedApplication().delegate! as! AppDelegate
        //print(delegate)
        //let panel = delegate.hudPanelController
        //panel.addObserver(self, forKeyPath: "window.visible", options: NSKeyValueObservingOptions([.New, .Old]), context: nil)
        //delegate.hudPanelController.window!.addObserver(self, forKeyPath: "visible", options: NSKeyValueObservingOptions([.Old, .New]), context: nil)
        
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        Swift.print(keyPath)
    }
    func hudChangedVisibility (notification:NSNotification) {
        "changed \(notification)"
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
