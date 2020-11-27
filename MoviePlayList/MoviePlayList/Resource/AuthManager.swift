//
//  AuthManager.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/26.
//  Copyright © 2020 shooooting. All rights reserved.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        DataBaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    print(result)
                    print(error)
                }
            }
        }
    }
    
    public func logInUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        
//        if let email = email {
//            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                <#code#>
//            }
//        }
    }
    
    public func logOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print("error")
            completion(false)
            return
        }
    }
}
