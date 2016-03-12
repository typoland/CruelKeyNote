//
//  CKNHudPanelController.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 22/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class CKNHudPanelController: NSWindowController, NSWindowDelegate{
    
    @IBOutlet weak var daysController:NSArrayController!
    @IBOutlet weak var eventsController:NSArrayController!
    var managedObjectContext:NSManagedObjectContext!
    
    @IBAction func closePanel(sender:AnyObject) {
        self.document = nil
        self.window?.close()
    }
  
   func windowShouldClose(sender: AnyObject) -> Bool {
    print ("close")
    //self.document?.canCloseDocumentWithDelegate(self, shouldCloseSelector: "closeIt:", contextInfo: nil)
    return true
    /*print(notification)
    
        print("closing")
        self.setDocumentEdited( false)
        self.document = nil
        //self.window
        //super.window?.close()
*/
    }
    func closeIt () {
        print ("closeIt")
        
        self.window?.close()
    }
    override func awakeFromNib() {
        self.window?.hidesOnDeactivate = true
        //self.document?.canCloseDocumentWithDelegate(self, shouldCloseSelector: "closeIt", contextInfo: nil)

        
    }
    
    func canAddMedia() -> Bool {
        return 0..<self.eventsController.arrangedObjects.count ~= self.eventsController.selectionIndex
    }
    @IBAction func removeMedia (sender:AnyObject) {
        if self.canAddMedia() {
            let event:Event = self.eventsController.arrangedObjects.objectAtIndex(self.eventsController.selectionIndex) as! Event
            event.media = nil
            event.mediaType = nil
            event.mediaName = nil
        }
    }
    @IBAction func addMedia(sender:AnyObject) {
        print(eventsController)
        let fileTypes = ["pdf", "png", "tiff", "jpeg"]
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = fileTypes
        
        panel.beginWithCompletionHandler { (result) ->  Void in
            if result == NSFileHandlingPanelOKButton {
                print(panel.URL)
                let image = NSImage(byReferencingURL: panel.URL!)
                print(image)
                if  self.canAddMedia() {
                    let event:Event = self.eventsController.arrangedObjects.objectAtIndex(self.eventsController.selectionIndex) as! Event
                    event.media = NSData(contentsOfURL: panel.URL!)
                    event.mediaType = panel.URL?.pathExtension
                    print(event)
                }
                
            }
        }
    }

    class func shared() -> CKNHudPanelController {
    
        return _sharedCKNHudPanelController
    }
}

let _sharedCKNHudPanelController = CKNHudPanelController(windowNibName: "CKNEditData")