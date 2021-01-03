//
//  Service.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2021/01/01.
//  Copyright © 2021 shooooting. All rights reserved.
//

import Firebase

struct Service {
    
    // MARK: - Firebase에서 로그인한 User 정보 가져오기
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
    
    // MARK: - Firebase에 저장된 데이터에서 이미지만 변경
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
    
    // MARK: - Firebase에 영화 리뷰 저장하기
    static func uploadReview(_ review: String, movieTitle: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": review,
                    "movieTitle": movieTitle,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        COLLECTION_REVIEWS.document(currentUid).collection(movieTitle).addDocument(data: data, completion: completion)
    }
    
    // MARK: - Firebase에서 영화 리뷰한 데이터 가져오기
    static func downReview(_ movieTitle: String, completion: @escaping ([Review]) -> Void) {
        var reviews = [Review]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_REVIEWS.document(currentUid).collection(movieTitle).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    reviews.append(Review(dictionary: dictionary))
                    completion(reviews)
                }
            })
        }
    }
}
