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
    
    public func fetch(uid: String? = nil) {
        self.loading.onNext(true)
        PostService.fetchPosts(for: uid).subscribe { [weak self] (posts) in
            guard let self = self else { return }
            self.loading.onNext(false)
            self.posts.onNext(posts)
        } onError: { [weak self] (error) in
            guard let self = self else { return }
            self.loading.onNext(true)
            self.error.onNext(.clientError(error.localizedDescription))
        } onCompleted: { [weak self] in
            guard let self = self else { return }
            self.loading.onNext(true)
            InfoLog("completed fetching posts")
        } onDisposed: {
        }.disposed(by: disposeBag)
    }
}
