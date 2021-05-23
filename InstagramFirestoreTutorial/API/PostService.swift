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
            FireBaseCollections.posts.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    observer.onError(NSError(domain: "ERROR Fetch Post", code: 0, userInfo: nil))
                    return
                }
                var posts: [Post] = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
                posts = posts.map { post in
                    let userId = post.ownerUid
                    DispatchQueue.global().async {
                        UserService.fetchUser(uid: userId).then { user in
                                post.ownerUsername = user.fullname
                                post.ownerImageUrl = user.profileImageUrl
                            }
                    }
                    return post
                }
                observer.onNext(posts)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func fetchPosts(for uid: String?) -> Observable<[Post]> {
        guard let uid = uid else { return PostService.fetchPosts() }
        return Observable<[Post]>.create { observer -> Disposable in
            let query: Query = FireBaseCollections.posts.whereField("ownerUid", isEqualTo: uid)
            
            query.getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else { return }
                var posts: [Post] = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
                posts = posts.map { post in
                    let userId = post.ownerUid
                    DispatchQueue.global().async {
                        UserService.fetchUser(uid: userId).then { user in
                            post.ownerUsername = user.fullname
                            post.ownerImageUrl = user.profileImageUrl
                        }
                    }
                    return post
                }
            }
            return Disposables.create()
        }
    }
    
}
