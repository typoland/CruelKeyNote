//
//  AppDelegate.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    var hudPanelController = CKNHudPanelController.shared()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to tear down your application
        let app:NSApplication = NSApplication.sharedApplication()
        print (app.mainWindow)
        print ("adding observer")
       app.addObserver(self, forKeyPath: "mainWindow", options: NSKeyValueObservingOptions([.New, .Old]), context: nil)
        print ("done observer")


    }
  
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //print("observe")
        //print(NSApplication.sharedApplication().mainWindow?.windowController?.document?.managedObjectContext)
        let document:Document? = NSApplication.sharedApplication().mainWindow?.windowController?.document as? Document
        
        hudPanelController.willChangeValueForKey("managedObjectContext")

        if  document?.managedObjectContext != nil {
            hudPanelController.managedObjectContext = document?.managedObjectContext
            hudPanelController.daysController = document?.daysController
            hudPanelController.eventsController = document?.eventsController
            hudPanelController.document = document
        }
        hudPanelController.didChangeValueForKey("managedObjectContext")
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
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

