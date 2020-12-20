//
//  AuthService.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/20.
//  Copyright © 2020 shooooting. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct profileAuth {
    let email: String
    let password: String
    let nickname: String
    let profileImage: UIImage
}

class AuthServiece {
    
    static let shared = AuthServiece()
    
    func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(profileAuth: profileAuth, completion: ((Error?) -> Void)?) {
        
        guard let imageData = profileAuth.profileImage.jpegData(compressionQuality: 0.3) else { return }
        // 데이터로 바꿔준다.
        let name = NSUUID().uuidString // 항상 다른 값이 출력되기 때문에 데이터를 저장하는데 활용!
        let storage = Storage.storage().reference(withPath: "/profileImage/\(name)")
        
        storage.putData(imageData, metadata: nil) { (meta, error) in // 이미지 파일 저장
            
            if let error = error {
                completion!(error)
                return
            }
            
            storage.downloadURL { (url, error) in // storage에 저장한 image파일 다운로드
                
                guard let profileImageUrl = url?.absoluteString else { return } // String타입으로
                
                Auth.auth().createUser(withEmail: profileAuth.email, password: profileAuth.password) { (result, error) in // 회원가입
                    
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return } // 회원 가입
                    
                    let data = ["email": profileAuth.email,
                                "password": profileAuth.password,
                                "nickname": profileAuth.nickname,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid] as [String: Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    // firestore에 collection은 users로 그 다음은 회원가입했을때 user의 id로 그렇게 data를 넣고
                }
            }
        }
    }
}
