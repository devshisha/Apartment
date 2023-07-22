//
//  Apartment.swift
//  Apartment
//
//  Created by Shikha Sharma on 21/07/23.
//

import Foundation

struct Apartment: Codable {
    let address: String
    let floor: String
    let doorNumber: String
    var inventory: [InventoryItem]
}
