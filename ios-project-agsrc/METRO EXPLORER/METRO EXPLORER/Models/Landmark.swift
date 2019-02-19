//
//  FavLandmark.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/14/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import Foundation

struct Landmark: Codable {
    let name: String
    let url: String
    let landmarkLat : Double
    let landmarkLong : Double
    let landmarkRating : float_t
    let landmarkAddress : String
}
