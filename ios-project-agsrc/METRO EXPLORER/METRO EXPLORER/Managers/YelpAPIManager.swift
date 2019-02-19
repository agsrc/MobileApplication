//
//  YelpAPIManager.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation
import UIKit

class YelpAPIManager{
    
    let yelpUrl = "https://api.yelp.com/v3/businesses/search"
    let method = "GET"
    let key = "Bearer HN4wjYaI8rSOPrwnwMf7lTCvZRSihesQ2W_mhmnNlWUI03F0OP_f3shN6_WTCZV7gfGC6Nar-IHCdKLHIwYeLKdtXYmVfUDIxZB9HhUZWCFRXOfDKpAOHQNk2b4QXHYx"
    
    let headerField = "Authorization"
    
    let term = "term"
    let termSelected = "food"
    let location = "location"
    let latitude = "latitude"
    let longitude = "longitude"
    
    // fetching landmarks and using escaping closure yelpData
    func fetchlandmarks(selectedStation : String, selectedLat : Double, selectedLon : Double , completion:@escaping(yelpData)->()) {
        
    
    var yelpTemp:yelpData!
    
    // parsing and storing URL
    var urlObj=URLComponents(string: yelpUrl)
    
    // parsing key-value pairs
    let queryItemToken = URLQueryItem(name: term, value: termSelected)
        _ = URLQueryItem(name: location, value: selectedStation.description)
    let queryItemLat = URLQueryItem(name: latitude, value: selectedLat.description)
    let queryItemLong = URLQueryItem(name: longitude, value: selectedLon.description)
    
    urlObj!.queryItems = [queryItemToken, queryItemLat, queryItemLong]
    
    let url = urlObj?.url!
    
    var request = URLRequest(url: url!)
    request.httpMethod = method
    request.setValue(key, forHTTPHeaderField: headerField)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        
        guard let response = response as? HTTPURLResponse else {
            
            return
        }
        
        guard response.statusCode == 200 else {
            
            return
        }
        
        guard let data = data else {
            
            return
        }
        
        do{
            let yelpDecoded=try JSONDecoder().decode(yelpData.self, from: data)
            
            yelpTemp=yelpDecoded
            
            
            
        }
            
        catch let error {
            
            print(error)
            
            
        }
        completion(yelpTemp)
    }
        
        
        task.resume()
        
    }
        
    }

