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
    //var hudPanelController = CKNHudPanelController.shared()
   // var hudIsVisible:Bool = false
    
    @IBOutlet weak var panel:CKNPanel!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to tear down your application
      
    }

    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
       
        
    }
    
    
    @IBAction func toggleCKNPanel(sender:AnyObject) {
       
            if panel.visible {
                panel.orderOut(self)
                
            } else {
                panel.makeKeyAndOrderFront(self)

            }
        
    }
}

