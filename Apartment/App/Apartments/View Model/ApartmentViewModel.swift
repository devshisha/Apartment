//
//  ApartmentViewModel.swift
//  Apartment
//
//  Created by Shikha Sharma on 22/07/23.
//

import Foundation

class ApartmentViewModel {
    private var apartments: [Apartment] = []
    
    func fetchApartmentsFromJSON() {
        //checking if file exists or now
        guard let fileURL = Bundle.main.url(forResource: "ApartmentList", withExtension: "json") else {
            print("Mock JSON file not found")
            return
        }
        
        // if file exists, fetch data from the file and decode
        do {
            let data = try Data(contentsOf: fileURL)
            apartments = try JSONDecoder().decode([Apartment].self, from: data)
        } catch {
            print("Error decoding mock JSON file: \(error)")
        }
        
    }
    
    func numberOfApartments() -> Int {
        return apartments.count
    }
    
    func apartment(at index: Int) -> Apartment {
        return apartments[index]
    }
}
