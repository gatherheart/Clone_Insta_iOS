//
//  PostViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/11.
//

import Foundation
import Firebase
import RxSwift

class PostViewModel {
    
    public enum PostError {
        case clientError(String)
        case serverError(String)
    }
    
    private let disposeBag = DisposeBag()
    public let posts : PublishSubject<[Post]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<PostError> = PublishSubject()
    
    public func fetch() {
        self.loading.onNext(true)
        PostService.fetchPosts().subscribe { (posts) in
            self.loading.onNext(false)
            print(posts)
            self.posts.onNext(posts)
        } onError: { (error) in
            self.loading.onNext(true)
            self.error.onNext(.clientError(error.localizedDescription))
            print(error)
        } onCompleted: {
            self.loading.onNext(true)
            print("completed fetching posts")
        } onDisposed: {
        }.disposed(by: disposeBag)
    }
}
