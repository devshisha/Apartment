//
//  InventoryViewModel.swift
//  Apartment
//
//  Created by Shikha Sharma on 22/07/23.
//

import Foundation

class InventoryViewModel {
    private var inventoryItems: [InventoryItem] = []
    
    func setInventoryItems(_ items: [InventoryItem]) {
        inventoryItems = items
    }
    
    func addItem(_ item: InventoryItem) {
        guard inventoryItems.count < 20 else {
            // Limit the maximum number of items to 20.
            return
        }
        
        inventoryItems.append(item)
    }
    
    func numberOfItems() -> Int {
        return inventoryItems.count
    }
    
    func item(at index: Int) -> InventoryItem {
        return inventoryItems[index]
    }
}
