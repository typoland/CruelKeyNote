//
//  CKNHudPanelController.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 22/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class CKNHudPanelController: NSWindowController {
    
    var doc:Document? = nil
    var managedObjectContext:NSManagedObjectContext? = nil
    var daysController:NSArrayController? = nil
    var eventsController:NSArrayController? = nil
    //@IBOutlet weak var daysController:CKNTimeArrayController!
    //@IBOutlet weak var eventsController:NSArrayController!
    @IBOutlet weak var daysTable:NSTableView? = nil
    
    
    override func awakeFromNib() {
        print("Panel Awaken")
        self.addObserver(self, forKeyPath: "document", options: NSKeyValueObservingOptions([.Old, .New]), context: nil)
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print ("observing in Panel")
        print(daysController)
        print(self.managedObjectContext)
        print(self.document)
        self.daysTable?.reloadData()
    }
    
    class func shared() -> CKNHudPanelController {
    
        return _sharedCKNHudPanelController
    }
}

let _sharedCKNHudPanelController = CKNHudPanelController(windowNibName: "CKNEditData")