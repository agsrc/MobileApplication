//
//  WmataAPIResponse.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation

struct Stations : Codable {
    let Stations: [StationsInfo]
    
}
struct StationsInfo : Codable {
    let Name : String?
    let Code: String?
    let StationTogether1 : String?
    let StationTogether2 : String?
    let LineCode1 : String?
    let LineCode2 : String?
    let LineCode3 : String?
    let LineCode4 : String?
    let Lat : Double?
    let Lon : Double?
    let Address : AddZoom?
}

struct AddZoom :Codable {
    let Street : String?
    let City: String?
    let State: String?
    let Zip: String?
}

