//
//  DragableOrderedSetTableViewDelegate.swift
//  OrderedSetTestSwift
//
//  Created by Łukasz Dziedzic on 10/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class DragableOrderedSetTableViewDelegate: NSObject {
    @IBOutlet weak var tableView:NSTableView!
    @IBOutlet weak var arrayController:NSArrayController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let entityName = arrayController.entityName {
            tableView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: entityName)])
            tableView.setDraggingSourceOperationMask(NSDragOperation.move, forLocal: true)
        }
        Swift.print("Source inited")
    }
    
    func tableView(_ tableView: NSTableView,
                   writeRowsWith rowIndexes: IndexSet,
                   to pboard: NSPasteboard) -> Bool {
        
        Swift.print("write rows to")
        let data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        if let entityName =  arrayController.entityName {
            pboard.declareTypes([NSPasteboard.PasteboardType(rawValue: entityName)], owner: self)
            pboard.setData(data, forType: NSPasteboard.PasteboardType(rawValue: entityName))
        }
        return true
    }
    
    func tableView(_ tableView: NSTableView,
                   validateDrop info: NSDraggingInfo,
                   proposedRow row: Int,
                   proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        Swift.print("validate drop")
        
        if info.draggingSource() as! NSTableView == tableView {
            if dropOperation == NSTableView.DropOperation.on {
                tableView.setDropRow(row, dropOperation: NSTableView.DropOperation.above)
            }
            if ((NSApplication.shared.currentEvent?.modifierFlags.contains(NSEvent.ModifierFlags.option)) != nil)  {
                return NSDragOperation.copy
            } else {
                return NSDragOperation.move
            }
            
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: NSTableView,
                   acceptDrop info: NSDraggingInfo,
                   row: Int,
                   dropOperation: NSTableView.DropOperation) -> Bool {
        Swift.print("accept drop")
        
        if let bindinginfo = arrayController.infoForBinding(NSBindingName.contentArray),
            let observedObject = bindinginfo[NSBindingInfoKey.observedObject] as? NSObject,
            let keyPath = bindinginfo[NSBindingInfoKey.observedKeyPath] as? String,
            let entityName = arrayController.entityName
        {
            
            let observedSet = observedObject.mutableOrderedSetValue(forKeyPath: keyPath)
            let pasteboard:NSPasteboard = info.draggingPasteboard()
            
            if let rowData = pasteboard.data(forType: NSPasteboard.PasteboardType(rawValue: entityName)),
                let rowIndexes = NSKeyedUnarchiver.unarchiveObject(with: rowData) as? NSIndexSet {
                
                if rowIndexes.firstIndex > row {
                    observedSet.moveObjects(at: rowIndexes as IndexSet, to: row)
                } else {
                    observedSet.moveObjects(at: rowIndexes as IndexSet, to: row-rowIndexes.count)
                }
            }
        }
        return true
    }
    
}
/*
 - (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)operation {
 
 NSDictionary *bindingInfo = [self.arrayController infoForBinding:@"contentArray"];
 NSMutableOrderedSet *s = [[bindingInfo objectForKey:NSObservedObjectKey] mutableOrderedSetValueForKeyPath:[bindingInfo objectForKey:NSObservedKeyPathKey]];
 
 NSPasteboard *pasteboard = [info draggingPasteboard];
 NSData *rowData = [pasteboard dataForType:[self.arrayController entityName]];
 NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
 if ([rowIndexes firstIndex] > row) {
 // we're moving up
 [s moveObjectsAtIndexes:rowIndexes toIndex:row];
 } else {
 // we're moving down
 [s moveObjectsAtIndexes:rowIndexes toIndex:row-[rowIndexes count]];
 }
 
 return YES;
 }
 */




