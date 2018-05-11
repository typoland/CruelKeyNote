//
//  DataToImageTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 11/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

//@objc
class DataToImageTransformer : ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSImage.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if value != nil {
            return NSImage(data:value! as! Data)
        }
        else {
            return NSImage(named: NSImage.Name.addTemplate)
        }
    }
    /*
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        return NSData.
        return NSOrderedSet(array: value as! [AnyObject])
    }
    */
}


extension NSValueTransformerName {
    static let dataToImageTransformer =
        NSValueTransformerName(rawValue: "DataToImageTransformer")
}

