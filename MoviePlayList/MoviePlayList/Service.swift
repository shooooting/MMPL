//
//  Service.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/10/23.
//  Copyright © 2020 shooooting. All rights reserved.
//

import Alamofire
import Foundation

struct Service {
    static let shared = Service()
    
    private let decoder = JSONDecoder()
    
//    func SearchMovie(searchString: String, completion: @escaping(SearchResult?) -> Void) {
//        let clientID: String = "8RNYIPCx6b6qFpZB6a2V"
//        let clientKey: String = "5Vs0V727Ij"
//        
//        let query: String = "https://openapi.naver.com/v1/search/movie.json?query=\(searchString)"
//        
//        AF.request(<#T##convertible: URLConvertible##URLConvertible#>)
//        
//        
//    }
}
