//
//  NotificationController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit
import RxSwift

class NotificationController: UIViewController {

    private let tableView = UITableView()
    private let viewModel = NotificationViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    private var notifications: [Notification] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTalbeView()
        self.bindData()
    }
    
    private func configureTalbeView() {
        view.backgroundColor = .clear
        navigationItem.title = "Notifications"
        
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    private func bindData() {
        viewModel.notifications.subscribe(onNext: { notifications in
            self.notifications = notifications
        }).disposed(by: disposeBag)
    }
    
    private func postImageUrl(index: Int) -> URL? {
        return URL(string: notifications[index].postImageUrl ?? "")
    }

    private func profileImageUrl(index: Int) -> URL? {
        return URL(string: notifications[index].userProfileImageUrl ?? "")
    }

    private func notificationMessage(index: Int) -> NSAttributedString {
        let username: String = notifications[index].username
        let message: String = notifications[index].type.notificationMessage

        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "  2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))

        return attributedText
    }
}

extension NotificationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as? NotificationCell else {
            return UITableViewCell()
        }
        cell.configure(notification: notifications[indexPath.row])
        return cell
    }
}
