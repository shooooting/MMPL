//
//  Service.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/01.
//  Copyright © 2021 shooooting. All rights reserved.
//

import Firebase

struct Service {
    
    static func LoginUser(completion: @escaping ([User]) -> Void) {
        var AuthUser = [User]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(currentUid).getDocument { DocumentSnapshot, error in
            
            if let error = error {
                print("DEBUG: LoginUser \(error.localizedDescription)")
                return
            }
            guard let dictionary = DocumentSnapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            AuthUser.append(user)
            completion(AuthUser)
        }
    }
    
    static func updateUserData(name: UIImage, completion: ((Error?) -> Void)?) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let imageData = name.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { meta, error in
            if let error = error {
                completion!(error)
            }
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Firestore.firestore().collection("users").document(currentUid).updateData(["profileImageUrl": profileImageUrl]) { error in
                    if let error = error {
                        print("DEBUG: updateUserData \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
}
