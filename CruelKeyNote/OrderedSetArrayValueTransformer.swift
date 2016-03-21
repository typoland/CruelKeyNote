//
//  OrderedSetValueTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 08/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation


@objc(OrderedSetArrayValueTransformer) class OrderedSetArrayValueTransformer : NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true;
        }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        return (value as! NSOrderedSet).array
    }

    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        return NSOrderedSet(array: value as! [AnyObject])
    }

}


