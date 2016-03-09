//
//  CKNEditData.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class CKNEditDataController:NSWindowController {
    
    class func shared() -> CKNEditDataController {
        println("TAKING SHARED Controller\(_sharedCKNPanelViewController)")
        return _sharedCKNPanelViewController
    }
    
    /*
    init(windowNibName : String, owner : AnyObject) {
        super.init (windowNibName: windowNibName, owner: owner)
            //super.init (windowNibName : windowNibName, owner : owner)
        //println("INIT CONTROLLER \(self)")
    }
    */
    /*
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    override func windowDidLoad() {
        println("OK")
    }
}

let _sharedCKNPanelViewController : CKNEditDataController =  CKNEditDataController(windowNibName:"CKNEditData")

    


