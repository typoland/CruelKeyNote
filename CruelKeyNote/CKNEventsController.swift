//
//  CKNEventsController.swift
//  BeBrief
//
//  Created by Łukasz Dziedzic on 21/03/16.
//  Copyright © 2016 tyPoland. All rights reserved.
//

//import Foundation
import AppKit

class CKNEventsController: NSArrayController {
    
    @objc func canAddMedia() -> Bool {
        return 0 ..< ( self.arrangedObjects as! [Any] ).count ~= self.selectionIndex
    }
    
    
    
    @IBAction func removeMedia (_ sender:Any) {
        if self.canAddMedia() {
            let event:Event = (self.arrangedObjects as! [Event])[self.selectionIndex]
            event.media = nil
            event.mediaName = nil
        }
    }
    
    @IBAction func addMedia(_ sender:Any) {
        //print(eventsController)
        let fileTypes = ["pdf", "png", "tiff", "jpeg"]
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = fileTypes
        
        panel.begin { (result) ->  Void in
            if result.hashValue == NSFileHandlingPanelOKButton {
                //print(panel.URL)
                //print(image)
                if  self.canAddMedia() {
                    let event:Event = (self.arrangedObjects as! [Event])[self.selectionIndex]
                    event.media = NSData(contentsOf: panel.url!)
                    //print(event)
                }
                
            }
        }
    }

}
