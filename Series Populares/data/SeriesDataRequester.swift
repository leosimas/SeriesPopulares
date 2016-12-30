//
//  SeriesDataRequester.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ReachabilitySwift

class SeriesDataRequester {
    
    static let sharedInstance = SeriesDataRequester()
    
    private init() {
        self.reachability = Reachability()!
    }
    
    var reachability : Reachability
    
    let API_KEY : String  = ""
    let BASE_URL : String = "https://api.themoviedb.org/3/"
    
    func isConnected() -> Bool {
        return self.reachability.isReachable
    }
    
    func listPopular( page : Int = 1, callback : @escaping (SeriesResponse?, String?) -> Void ) {
        let url = BASE_URL.appending("tv/popular")
        
        let parameters : Parameters = [
            "api_key" : API_KEY,
            "page" : String(page)
        ]
        
        Alamofire.request(url, parameters : parameters)
            .validate()
            .validate(contentType: ["application/json"])
            .responseObject { (response: DataResponse<SeriesResponse>) in
                
                if (response.result.isFailure) {
                    let error = response.result.error
                    print( "erro: \(error)" )
                    
                    callback(nil, "Ocorreu um erro ao buscar as séries.")
                    return
                }
                
                let seriesReponse = response.result.value
                
                callback(seriesReponse!, nil)
            
            }
        
    }
    
    class func getPosterUrl(serie : Serie) -> String {
        let url = "https://image.tmdb.org/t/p/w185" // w185 -> tamanho bom para mobile
        return url.appending(serie.posterPath!)
    }
    
}
