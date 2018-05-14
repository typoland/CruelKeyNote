//
//  OrderedSetValueTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 08/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation


class OrderedSetArrayValueTransformer : ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true;
        }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if let orderedSet = (value as? NSOrderedSet) {
            return orderedSet.array as AnyObject
        }
        return nil
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        if let array = value as? [AnyObject] {
            return NSOrderedSet(array: array)
        }
        return nil
    }

}

extension NSValueTransformerName {
    static let orderedSetArrayValueTransformer =
        NSValueTransformerName(rawValue: "OrderedSetArrayValueTransformer")
}


