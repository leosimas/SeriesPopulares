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


class SeriesDataRequester {
    
    static let sharedInstance = SeriesDataRequester()
    
    private init() {
    }
    
    let API_KEY : String  = "1a4ca4de4639c5e847b5b15b2477dd81"
    let BASE_URL : String = "https://api.themoviedb.org/3/"
    
    let ERROR_NO_CONNECTION = -1009
    
    func listPopular( page : Int = 1, callback : @escaping (SeriesResponse?, String?) -> Void ) {
        let url = BASE_URL.appending("tv/popular")
        
        let parameters : Parameters = [
            "api_key" : API_KEY,
            "page" : String(page)
        ]
        
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(url, parameters : parameters)
            .validate()
            .validate(contentType: ["application/json"])
            .responseObject { (response: DataResponse<SeriesResponse>) in
                
                if (response.result.isFailure) {
                    let error = response.result.error
                    print( "erro: \(error)" )
                    //"Ocorreu um erro ao buscar as séries."
                    
                    var errorMsg : String?
                    /*
                    let err = error as? NSURLError
                    if (err != nil) {
                        errorMsg = "Ocorreu um erro. Verifique sua conexão."
                    } else {
                        errorMsg = "Ocorreu um erro ao buscar as séries."
                    }
                    */
                    
                    // FIXME tratar > sem internet
                    errorMsg = "Ocorreu um erro ao buscar as séries."
                    
                    callback(nil, errorMsg!)
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
