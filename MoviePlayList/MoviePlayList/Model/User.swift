//
//  ProfileAuth.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/01.
//  Copyright © 2021 shooooting. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let nickname: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.nickname = dictionary["nickname"] as? String ?? ""
    }
}
