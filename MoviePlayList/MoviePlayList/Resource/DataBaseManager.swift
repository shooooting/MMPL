//
//  DataBaseManager.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/25.
//  Copyright © 2020 shooooting. All rights reserved.
//

import FirebaseDatabase

public class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
    
}
