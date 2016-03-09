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
    var hudPanelController = CKNHudPanelController.shared()
    /*
    var _managedObjectContext:NSManagedObjectContext? = nil
    var _persistentStoreCoordinator:NSPersistentStoreCoordinator?=nil
    var _managedObjectModel:NSManagedObjectModel? = nil
    */
    
    func windowDidBecomeKey(notification:NSNotification)
    {
        hudPanelController.managedObjectContext = self.managedObjectContext
        if let table = hudPanelController.daysTable != nil {
            hudPanelController.daysTable!.reloadData()
        }
        //print("windowDidBecomeKey: \(hudPanelController.daysController.content)")
        //print("table \(hudPanelController.daysTable)")

    }
    func windowDidResignKey(notification:NSNotification) {
        hudPanelController.managedObjectContext = nil
        
    if hudPanelController.daysTable != nil {
            hudPanelController.daysTable!.reloadData()
        }
        //print("windowDidResignKey: \(hudPanelController.daysController.content)")

    }
    
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        print("Panel \(self.managedObjectContext)")
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

    @IBAction func showPanel(sender:AnyObject) {
        print("OrderFront \(hudPanelController)")
        hudPanelController.window?.makeKeyAndOrderFront(self)
    }
    @IBAction func hidePanel(sender:AnyObject) {
        print("OrderOut \(hudPanelController)")
        hudPanelController.window?.orderOut(self)
    }
}
