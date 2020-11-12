//
//  MakeListData.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/11.
//  Copyright © 2020 shooooting. All rights reserved.
//

import Foundation

class dataManager {
  
  static let shared: dataManager = dataManager()
  var searchResult: SearchResult?
  
  private init() {
  }
    
    
    
}

struct SearchResult: Codable {
    var lastBuildDate: String
    var total: Int
    var start: Int
    var display: Int
    var items: [MovieInfo]
}

struct MovieInfo: Codable {
    var title: String
    var link: String
    var image: String
    var subtitle: String
    var pubDate: String
    var director: String
    var actor: String
    var userRating: String
}

