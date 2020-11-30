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
    
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true) // 회원가입을 하면 자동으로 로그인이 된다.
    }
    
    public func insertNewUser(widh email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username" : username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
