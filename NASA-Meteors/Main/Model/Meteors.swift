//
//  Loads.swift
//  Vids Tube
//
//  Created by JOY JOSE on 15/02/19.
//  Copyright © 2019 Riverswave Technologies Ltd. All rights reserved.
//

import UIKit



struct Meteors: Decodable {
    var id: String?
    var name:String?
    var year: String?
    var nametype: String?
    var recclass: String?
    var mass:String?
    var reclon:String?
    var reclat:String?
    var geoLocation: GeoLocation?
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case year = "year"
        case nametype = "nametype"
        case recclass = "recclass"
        case mass = "mass"
        case geoLocation = "geolocation"
        case reclon = "reclong"
        case reclat = "reclat"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            geoLocation = try values.decode(GeoLocation.self, forKey: .geoLocation)
            self.id = try values.decode(String.self, forKey: .id)
            self.name = try values.decode(String.self, forKey: .name)
            self.year = try values.decode(String.self, forKey: .year)
            self.nametype = try values.decode(String.self, forKey: .nametype)
            self.recclass = try values.decode(String.self, forKey: .recclass)
            self.mass = try values.decode(String.self, forKey: .mass)
            self.reclon = try values.decode(String.self, forKey: .reclon)
            self.reclat = try values.decode(String.self, forKey: .reclat)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
struct GeoLocation: Decodable {
    var type: String?
    var coordinates = [Double]()
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case coordinates = "coordinates"
    }
    init(from decoder: Decoder) throws {
           do {
               let values = try decoder.container(keyedBy: CodingKeys.self)

               self.type = try values.decode(String.self, forKey: .type)
               self.coordinates = try values.decode([Double].self, forKey: .coordinates)
           }
           catch {
               print(error.localizedDescription)
           }
       }
}

