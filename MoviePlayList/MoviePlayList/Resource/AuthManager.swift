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
                
                Auth.auth().createUser(withEmail: email, password: password) { user, error in
                    if user != nil {
                        print("success")
                        completion(true)
                    } else {
                        print("fail")
                        completion(false)
                    }
                    
                    DataBaseManager.shared.insertNewUser(widh: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    public func logInUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            if user != nil {
                print("success")
                completion(true)
            } else {
                print("failed")
                completion(false)
            }
        }
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
