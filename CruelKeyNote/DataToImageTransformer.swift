//
//  DataToImageTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 11/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

@objc(DataToImageTransformer) class DataToImageTransformer : NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSImage.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        if value != nil {
            return NSImage(data:value! as! NSData)
        }
        else {
            return NSImage(named: NSImageNameAddTemplate)
        }
    }
    /*
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        return NSData.
        return NSOrderedSet(array: value as! [AnyObject])
    }
    */
}

