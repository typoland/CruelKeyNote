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
    
    var managedObjectContext:NSManagedObjectContext? = nil
    @IBOutlet weak var daysController:CKNTimeArrayController!
    @IBOutlet weak var eventsController:NSArrayController!
    @IBOutlet weak var daysTable:NSTableView? = nil
    
    class func shared() -> CKNHudPanelController {
    
        return _sharedCKNHudPanelController
    }
}

let _sharedCKNHudPanelController = CKNHudPanelController(windowNibName: "CKNEditData")