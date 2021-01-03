//
//  Movie.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/02.
//  Copyright © 2021 shooooting. All rights reserved.
//

import Firebase

struct Review {
    let text: String
    let movieTitle: String
    let timestamp: Timestamp!
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.movieTitle = dictionary["movieTitle"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
