//
//  SatelliteData.swift
//  API_Project
//
//  Created by english on 2024-03-15.
//

import Foundation
import UIKit

struct Info : Codable {
    let satname: String
    let satid : Int
    let transactionscount: Int
}

struct Position: Codable {
    let satlatitude: Double
    let satlongitude: Double
    let sataltitude: Double
    let azimuth: Double
    let elevation: Double
    let ra: Double
    let dec: Double
    let timestamp: Double
    let eclipsed: Bool
}


struct SatelliteData : Encodable, Decodable {
    let info: Info
    let positions: [Position]
}


//Examples:
/*
 {
 "info": {
 "satname": "DELTA 2 DEB (DPAF)",
 "satid": 27000,
 "transactionscount": 5
 },
 "positions": [
 {
 "satlatitude": 14.37857325,
 "satlongitude": 170.80480606,
 "sataltitude": 1319.96,
 "azimuth": 296.34,
 "elevation": -43.64,
 "ra": 274.77315124,
 "dec": -12.71731862,
 "timestamp": 1710536525,
 "eclipsed": false
 },
 {
 "satlatitude": 14.42747865,
 "satlongitude": 170.82380424,
 "sataltitude": 1319.97,
 "azimuth": 296.36,
 "elevation": -43.61,
 "ra": 274.78602075,
 "dec": -12.68684856,
 "timestamp": 1710536526,
 "eclipsed": false
 }
 ]
 }
 */
