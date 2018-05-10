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

    
    @IBOutlet weak var panel:CKNPanel!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to tear down your application
        Swift.print("AppFinish Lounching...")
        ValueTransformer.setValueTransformer(DataToImageTransformer(),
                                             forName: .dataToImageTransformer)
        ValueTransformer.setValueTransformer(TimeIntervalTransformer(),
                                             forName: .timeIntervalTransformer)
        ValueTransformer.setValueTransformer(OrderedSetArrayValueTransformer(),
                                             forName: .orderedSetArrayValueTransformer)
      Swift.print("....AppFinish Lounching")
    }

    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
       
        
    }
    
    
    @IBAction func toggleCKNPanel(sender:AnyObject) {
       
        if panel.isVisible {
                panel.orderOut(self)
                
            } else {
                panel.makeKeyAndOrderFront(self)

            }
        
    }
}

