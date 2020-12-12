//
//  APIManager.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/02.
//  Copyright © 2020 shooooting. All rights reserved.
//
import Alamofire
import RxSwift
import UIKit

public class APIManager {
    static let shared = APIManager()
    private init() { }
    
    private let decoder = JSONDecoder()
    
    private let clientID: String = "8RNYIPCx6b6qFpZB6a2V"
    private let clientKey: String = "5Vs0V727Ij"
    
    private let headerID = "X-naver-Client-Id"
    private let headerKey = "X-naver-Client-Secret"
    
    func requestSearchAPI(queryValue: String, completion: @escaping (SearchResult) -> Void) {
        let query = "https://openapi.naver.com/v1/search/movie.json"
        let headersID: HTTPHeaders = [headerID: clientID, headerKey: clientKey]
        let paramter: Parameters = ["query": queryValue]
        
        AF.request(query, method: .get, parameters: paramter, headers: headersID).responseJSON { response in
            
            guard let jsonData = response.data else {
                return
            }
            do {
                let data = try self.decoder.decode(SearchResult.self, from: jsonData)
                completion(data)
            } catch {
                print("DEBUG: Search Products Request Error, ", error.localizedDescription)
            }
        }
        
    }
    
    func requestAPI(queryValue: String, completion: @escaping ([SearchResult]) -> Void) {
        
        var searchData = [SearchResult]()
        let clientID: String = "8RNYIPCx6b6qFpZB6a2V"
        let clientKey: String = "5Vs0V727Ij"
        
        let query: String = "https://openapi.naver.com/v1/search/movie.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-naver-Client-Id")
        requestURL.addValue(clientKey, forHTTPHeaderField: "X-naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard error == nil else { return completion(searchData)}
            guard let data = data else { return completion(searchData)}
            
            do {
                let searchInfo: SearchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                DispatchQueue.main.async {
                    searchData.append(searchInfo)
                }
                //                    searchData.append(searchInfo)
                print(searchData)
                completion(searchData)
                //                    dataManager.shared.searchResult = searchInfo
                //                    self.data.append(searchInfo)
                
            } catch {
                print(error)
            }
            
            //            if let jsonData = try? JSONDecoder().decode([SearchResult].self, from: data) {
            
            //        let selectData: SearchResult
            //        for jData in jsonData.items {
            //            print(data.title, data.userRating)
            //            let score: Double
            //            score = Double(data.userRating) ?? 0
            //        }
            //                searchData.append(contentsOf: jsonData)
            //                print(jsonData)
            //                completion(searchData)
            //                self.data = jsonData
            //                DispatchQueue.main.async { // ui를 변경하는 queue에 이 내용을 짚어 넣는다.
            //                    let vc = MakeListViewController()
            //                    vc.collectionV.reloadData()
            //                    self.collectionV.reloadData()
            //                }
            //            }
            //            completion(searchData)
        }
        task.resume()
    }
}
