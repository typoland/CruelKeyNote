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
        if hudPanelController.daysTable != nil {
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
        //hudPanelController = CKNHudPanelController.shared()
        print("Panel \(self.managedObjectContext)")
        //print(hudPanelController.document)
        //showPanel(self)
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
    /*
    func applicationFilesDirectory() -> NSURL {
        var fileManager:NSFileManager = NSFileManager.defaultManager()
        var libraryURL:NSURL  = fileManager.URLsForDirectory(NSSearchPathDirectory.LibraryDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as NSURL!
        return libraryURL.URLByAppendingPathComponent("CruelKeyNote")
    }
    
    func managedObjectModel()->NSManagedObjectModel {
        if ((_managedObjectModel) != nil) {
            return _managedObjectModel!
        }
        var modelURL:NSURL = NSBundle.mainBundle().URLForResource("CruelKeyNote", withExtension: "momd")!
        _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        return _managedObjectModel!
    }
    
    func persistentStoreCoordinator()->NSPersistentStoreCoordinator? {
        if (_persistentStoreCoordinator != nil) {
            return _persistentStoreCoordinator!
        }
        var mom:NSManagedObjectModel = self.managedObjectModel()
        var fileManager:NSFileManager = NSFileManager.defaultManager()
        var applicationFilesDirectory = self.applicationFilesDirectory()
        var error:NSError?
        var properties:[NSObject:AnyObject] = applicationFilesDirectory.resourceValuesForKeys([NSURLIsDirectoryKey], error: &error)!
        
        if error != nil {
            var ok:Bool = false
            if error!.code == NSFileReadNoSuchFileError {
                ok = fileManager.createDirectoryAtPath(applicationFilesDirectory.path!, withIntermediateDirectories: true, attributes: nil, error: &error)
                if !ok {
                    NSApplication.sharedApplication().presentError(error!)
                    return nil
                }
            }
            else {
                if ((properties[NSURLIsDirectoryKey] as Bool) != true) {
                    var failureDescription:String = String(format: "Expected a folder to store application data, found a file (%@).", arguments: applicationFilesDirectory.path)

                    var dict:[NSObject:AnyObject]
                    dict[NSLocalizedDescriptionKey] = failureDescription
                    error = NSError(domain: "YOUR ERROR DOMAIN", code: 101, userInfo: dict)
                    NSApplication.sharedApplication().presentError(error!)
                    return nil;
                }
            }
            var url:NSURL = applicationFilesDirectory.URLByAppendingPathComponent("CruelKeyNote.storeData")
            
        }
    }
    
    func managedObjectContext() -> NSManagedObjectContext {
        if (_managedObjectContext != nil) {
            return _managedObjectContext!
        }
        var coordinator:NSPersistentStoreCoordinator = self.per
    }
*/
    @IBAction func showPanel(sender:AnyObject) {
        print("OrderFront \(hudPanelController)")
        hudPanelController.window?.makeKeyAndOrderFront(self)
    }
    @IBAction func hidePanel(sender:AnyObject) {
        print("OrderOut \(hudPanelController)")
        hudPanelController.window?.orderOut(self)
    }
}
