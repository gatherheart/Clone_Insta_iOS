//
//  NotificationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/06/09.
//

import Foundation
import Firebase
import RxSwift

class NotificationViewModel {

    public enum NotificationError {
        case clientError(String)
        case serverError(String)
    }
    
    private let disposeBag = DisposeBag()
    public let notifications: PublishSubject<[Notification]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<NotificationError> = PublishSubject()
    
    public func fetch() {
        self.loading.onNext(true)
        NotificationService().fetchNotifications().then { [weak self] (notifications) in
            guard let self = self else { return }
            self.loading.onNext(false)
            self.notifications.onNext(notifications)
        }
    }
}
