//
//  YelpResponse.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation

struct yelpData : Codable{
    let businesses : [openYelpFields]
}

struct openYelpFields : Codable{
    let id : String?
    let alias : String?
    let name : String?
    let image_url : String?
    let url : String?
    let review_count : Int?
    let categories : [categoryFields]
    let rating : float_t?
    let coordinates : cordinateFields
    let transactions : [String]?
    let price : String?
    let location : locationFields?
    let phone : String?
    let display_phone : String?
    let distance : Double?
}

// fields in category
struct categoryFields : Codable{
    let alias : String?
    let title : String?
    
}

// fields in location

struct locationFields : Codable{
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let zip_code : String?
    let country : String?
    let state : String?
    let display_address : [String]?
}

struct cordinateFields : Codable{
    let latitude : Double?
    let longitude : Double?
}
