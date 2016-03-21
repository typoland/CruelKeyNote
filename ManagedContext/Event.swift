//
//  Event.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 11/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import CoreData
import AppKit

@objc(Event)
class Event: NSManagedObject {
    
// Insert code here to add functionality to your managed object subclass
    
    func image() -> NSImage {
        if self.media != nil {
            return NSImage(data: self.media!)!
        } else {
            return NSImage(named: NSImageNameStopProgressTemplate)!
        }
    }
    
}
