//
//  Serie.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import Foundation
import ObjectMapper

class Serie : Mappable {
    
    var id : Int?
    var name : String?
    var posterPath : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        posterPath <- map["poster_path"]
    }
    
}
