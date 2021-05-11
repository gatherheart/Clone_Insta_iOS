//
//  PostService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/11.
//

import UIKit
import RxSwift
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage) -> Observable<PostData> {
        return Observable<PostData>.create { observer -> Disposable in
            guard let uid = Auth.auth().currentUser?.uid else {
                observer.onError(NSError(domain: "ERROR Upload Post", code: 0, userInfo: nil))
                return Disposables.create()
            }

            ImageUploader.upload(image: image, firestoreManger: FirestoreManager()).then { imageUrl in
                let data: PostData = ["caption": caption,
                                           "timestamp": Timestamp(date: Date()),
                                           "likes": 0,
                                           "imageUrl": imageUrl,
                                           "ownerUid": uid]
                observer.onNext(data)
                FireBaseCollections.posts.addDocument(data: data) {_ in
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    static func fetchPosts() -> Observable<[Post]> {
        return Observable<[Post]>.create { observer -> Disposable in
            FireBaseCollections.posts.getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    observer.onError(NSError(domain: "ERROR Fetch Post", code: 0, userInfo: nil))
                    return
                }

                let posts: [Post] = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
                observer.onNext(posts)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
