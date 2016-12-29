//
//  SeriesResponse.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import Foundation
import ObjectMapper

class SeriesResponse : Mappable {
    
    var totalPages : Int?
    var results : [Serie]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalPages <- map["total_pages"]
        results <- map["results"]
    }
    
}
