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
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: arrayController.entityName!)])
        tableView.setDraggingSourceOperationMask(NSDragOperation.move, forLocal: true)
    }
    
    func tableView( tableView: NSTableView,
        writeRowsWithIndexes rowIndexes: NSIndexSet,
        toPasteboard pasteboard: NSPasteboard) -> Bool {
            
        let data:NSData = NSKeyedArchiver.archivedData(withRootObject: rowIndexes) as NSData
        pasteboard.declareTypes([NSPasteboard.PasteboardType(rawValue: arrayController.entityName!)], owner: self)
        pasteboard.setData(data as Data, forType: NSPasteboard.PasteboardType(rawValue: arrayController.entityName!))
            return true
    }
    
    func tableView(tableView: NSTableView,
        validateDrop info: NSDraggingInfo,
        proposedRow row: Int,
        proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
            if info.draggingSource() as! NSTableView == tableView {
                if dropOperation == NSTableView.DropOperation.on {
                    tableView.setDropRow(row, dropOperation: NSTableView.DropOperation.above)}
                if ((NSApplication.shared.currentEvent?.modifierFlags.contains(NSEvent.ModifierFlags.option)) != nil)  {
                    return NSDragOperation.copy
                } else {
                    return NSDragOperation.move
                }
                
            } else {
                return []
            }
    }
   
    func tableView(tableView: NSTableView,
        acceptDrop info: NSDraggingInfo,
        row: Int,
        dropOperation: NSTableView.DropOperation) -> Bool {
        let bindinginfo = arrayController.infoForBinding(NSBindingName.contentArray)!
        
            //a
        let observedObject = bindinginfo[NSBindingInfoKey.observedObject]! as! NSObject
        let keyPath = bindinginfo[NSBindingInfoKey.observedKeyPath]! as! String
        let set = observedObject.mutableOrderedSetValue(forKeyPath: keyPath)
            //a
        /*
        let set:NSMutableOrderedSet = bindinginfo.objectForKey(NSObservedObjectKey)!.mutableOrderedSetValueForKeyPath(bindinginfo.objectForKey(NSObservedKeyPathKey) as! String)
 */
            let pasteboard:NSPasteboard = info.draggingPasteboard()
        let rowData = pasteboard.data(forType: NSPasteboard.PasteboardType(rawValue: arrayController.entityName!))! 
        let rowIndexes:NSIndexSet = NSKeyedUnarchiver.unarchiveObject(with: rowData) as! NSIndexSet
            if rowIndexes.firstIndex > row {
                set.moveObjects(at: rowIndexes as IndexSet, to: row)
            } else {
                set.moveObjects(at: rowIndexes as IndexSet, to: row-rowIndexes.count)
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




