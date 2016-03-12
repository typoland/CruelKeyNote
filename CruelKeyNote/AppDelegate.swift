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
    var hudIsVisible:Bool = false
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to tear down your application
        
        let app:NSApplication = NSApplication.sharedApplication()
       app.addObserver(self, forKeyPath: "mainWindow", options: NSKeyValueObservingOptions([.New, .Old]), context: nil)
        /*
        hudPanelController.addObserver(self, forKeyPath: "window", options: NSKeyValueObservingOptions([.New]), context: nil)
        //print ("done observer")
        NSNotificationCenter.defaultCenter().addObserver(
            hudPanelController.window!,
            selector: "hudChangedVisibility:",
            name: "CKNHudPanelControllerChanged",
            object: hudPanelController)
        */
    }
  
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath != nil {
        switch keyPath! {
        case "mainWindow" :
            let document:Document? = (NSApplication.sharedApplication().mainWindow?.windowController?.document as? Document)
            //print(hudPanelController.daysController?.content)
            hudPanelController.managedObjectContext = document?.managedObjectContext
            if  hudPanelController.daysController != nil {
            print (hudPanelController.daysController)
            hudPanelController.daysController?.managedObjectContext = document?.managedObjectContext
            }
            print("WindowChanged")
        //case "window":
           // hudIsVisible = hudPanelController.window != nil
            //print ("Hud changed \(hudIsVisible)")
        default: ()
        }
        }
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    @IBAction func showPanel(sender:AnyObject) {
        print("OrderFront \(hudPanelController)")
        hudPanelController.window?.makeKeyAndOrderFront(self)
        hudIsVisible = true
    }
    @IBAction func hidePanel(sender:AnyObject) {
        print("Hide \(hudPanelController)")
        hudPanelController.window?.orderOut(self)
        hudIsVisible = false
    }


}

