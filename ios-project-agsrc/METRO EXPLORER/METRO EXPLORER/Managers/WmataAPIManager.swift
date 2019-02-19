//
//  WmataAPIManager.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation

// to store response

//var universal = [String]()


class WmataAPIManager{
    
    //WMATA's API Credentials
    
    let apiUrl = "https://api.wmata.com/Rail.svc/json/jStations"
    let callingMethod = "GET"
    let key = "cf7675512b6b450395270a38112a4042"
    let headerField = "api_key"
    
    // escaping closure station_data
    func fetchMetroStation(completion:@escaping(Stations)->()){
        
        var st_data : Stations!
        
        let urlObj=URLComponents(string: apiUrl)!
        let url = urlObj.url!
        var request = URLRequest(url: url)
        request.httpMethod = callingMethod
        request.setValue(key, forHTTPHeaderField: headerField)
        
        // retrieves the content of the URL
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
                // decoding our codable i.e. station_data
                let st_decoded=try JSONDecoder().decode(Stations.self, from: data)
                
                st_data=st_decoded
             }
            catch let error{
                print(error)
            }
            completion(st_data)

    }
            // resume task if suspended
            task.resume()
}
}
    

