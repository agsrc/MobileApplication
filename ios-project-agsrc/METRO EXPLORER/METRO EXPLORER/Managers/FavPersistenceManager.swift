//
//  FavPersistenceManager.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/14/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation

class FavPersistenceManager {
    
    static let sharedInstance = FavPersistenceManager()
    
    let landmarkID = "favLandmark"
    // sroting favorite landmarks
    func saveFavoriteLandmarks(favorites: Landmark)-> Bool {
        let userDefaults = UserDefaults.standard
        
        var myFavs = fetchFavLandmarks()
        
        for value in myFavs{
            if(value.name==favorites.name){
                return false
            }
            
        }
        myFavs.append(favorites)
        
        let encoder = JSONEncoder()
        let encodedFavLandmarks = try? encoder.encode(myFavs)
        
        userDefaults.set(encodedFavLandmarks, forKey: landmarkID)
        return true
    }
    // fetch and decode landmarks
    func fetchFavLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let favoritesData = userDefaults.data(forKey: landmarkID), let myFavoriteLandmarks = try? JSONDecoder().decode([Landmark].self, from: favoritesData) {
            
            // decoding successfull
            return myFavoriteLandmarks
        }
        else {
            return [Landmark]()
        }
    }
    // remove favorite landmarks
    func remove(name: String) {
        let userDefaults = UserDefaults.standard
        var myFavLandmarks = fetchFavLandmarks()
        var indexone : Int
        
        for (index, element) in myFavLandmarks.enumerated() {
            if element.name == name{
                indexone = index
                myFavLandmarks.remove(at: indexone)
            }
        }
        // encoding favorite landmarks
        let encoder = JSONEncoder()
        let encodedFavLandmarks = try? encoder.encode(myFavLandmarks)
        
        userDefaults.set(encodedFavLandmarks, forKey: landmarkID)
    
}
}
