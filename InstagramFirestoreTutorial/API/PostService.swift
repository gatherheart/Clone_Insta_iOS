//
//  PostService.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/11.
//

import UIKit
import RxSwift
import Promises
import Firebase

struct PostService {
    
    enum UserCollections: String {
        case userWhoLike
    }
    
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
            let query: Query = FireBaseCollections.posts.order(by: "timestamp", descending: true).whereField("ownerUid", isEqualTo: uid)
            
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
                observer.onNext(posts)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func isLiked(postId: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            guard let myId = User.me?.uid else {
                observer.onError(NSError(domain: "ERROR like post: no myId", code: 0, userInfo: nil))
                return Disposables.create()
            }
            FireBaseCollections.likes.document(postId).collection(UserCollections.userWhoLike.rawValue).document(myId).getDocument { snapshot, error in
                if snapshot?.exists == true {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func likes(postId: String) -> Observable<[User]> {
        return Observable<[User]>.create { observer -> Disposable in
            FireBaseCollections.likes.document(postId).collection(UserCollections.userWhoLike.rawValue).getDocuments { snapshot, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let documents = snapshot?.documents else {
                    observer.onError(NSError(domain: "ERROR likes: no documents", code: 0, userInfo: nil))
                    return
                }
                let userIds = documents.map { $0.documentID }
                UserService.fetchUsers().then { users in
                    let users = users.filter { userIds.contains($0.uid) }
                    InfoLog("users who like this post: \(users)")
                    observer.onNext(users)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    static func like(postId: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            guard let myId = User.me?.uid else {
                observer.onError(NSError(domain: "ERROR like post: no myId", code: 0, userInfo: nil))
                return Disposables.create()
            }

            FireBaseCollections.likes.document(postId).collection(UserCollections.userWhoLike.rawValue).document(myId).setData([:]) { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func unlike(postId: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            guard let myId = User.me?.uid else {
                observer.onError(NSError(domain: "ERROR like post: no myId", code: 0, userInfo: nil))
                return Disposables.create()
            }

            FireBaseCollections.likes.document(postId).collection(UserCollections.userWhoLike.rawValue).document(myId).delete() { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
