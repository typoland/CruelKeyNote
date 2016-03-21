//
//  CKNEventsController.swift
//  BeBrief
//
//  Created by Łukasz Dziedzic on 21/03/16.
//  Copyright © 2016 tyPoland. All rights reserved.
//

import Foundation
import AppKit

class CKNEventsController: NSArrayController {
    func canAddMedia() -> Bool {
        return 0..<self.arrangedObjects.count ~= self.selectionIndex
    }
    
    @IBAction func removeMedia (sender:AnyObject) {
        if self.canAddMedia() {
            let event:Event = self.arrangedObjects.objectAtIndex(self.selectionIndex) as! Event
            event.media = nil
            event.mediaType = nil
            event.mediaName = nil
        }
    }
    @IBAction func addMedia(sender:AnyObject) {
        //print(eventsController)
        let fileTypes = ["pdf", "png", "tiff", "jpeg"]
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = fileTypes
        
        panel.beginWithCompletionHandler { (result) ->  Void in
            if result == NSFileHandlingPanelOKButton {
                //print(panel.URL)
                //print(image)
                if  self.canAddMedia() {
                    let event:Event = self.arrangedObjects.objectAtIndex(self.selectionIndex) as! Event
                    event.media = NSData(contentsOfURL: panel.URL!)
                    event.mediaType = panel.URL?.pathExtension
                    //print(event)
                }
                
            }
        }
    }

}
