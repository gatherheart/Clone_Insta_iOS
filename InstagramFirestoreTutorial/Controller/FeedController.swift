//
//  FeedController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import CocoaLumberjack

class FeedController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    var user: User? = nil
    var viewModel = PostViewModel()
    var observations: [NSKeyValueObservation] = [NSKeyValueObservation]()
    
    lazy private var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        return control
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        observations.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.collectionView.refreshControl = self.refreshControl
        setupBindings()
        viewModel.fetch(uid: user?.uid)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observations.removeAll()
        InfoLog("[🙀] viewDidDisappear in FeedController - observations \(String(describing: observations.count))")
    }
    
    private func commonInit() {
        setCollectionView()
        if user == nil {
            navigationItem.title = "Feed"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logout))
        }
    }
    
    private func setupBindings() {
        viewModel.posts
            .observe(on: MainScheduler.instance)
            .bind(to: self.collectionView.rx.items(cellIdentifier: FeedCollectionViewCell.reuseIdentifier)) { [weak self] row, post, cell in
                guard let self = self, let cell: FeedCollectionViewCell = cell as? FeedCollectionViewCell else { return }
                cell.configure(post: post)
                cell.didTapCommentBlock = { [weak self] in
                    guard let self = self else { return }
                    let vc = CommentController(collectionViewLayout: UICollectionViewFlowLayout())
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                let observation = post.observe(\.ownerImageUrl, options: [.new]) { post, change in
                    InfoLog("[🙀] NEW in observation \(String(describing: change.newValue))")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                self.observations.append(observation)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                guard let self = self else { return }
            }.disposed(by: disposeBag)

    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        collectionView.backgroundColor = .white
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
    }
    
    @objc
    private func logout() {
        AuthUseCase.logout { [weak self] in
            guard let self = self else { return }
            self.showLoginController(sender: self)
        }
    }
    
    func showLoginController(sender: UIViewController) {
        let controller = LoginController()
        controller.delegate = self.tabBarController as? MainTabController
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        sender.present(nav, animated: true, completion: nil)
    }
    
    @objc
    private func refreshData() {
        viewModel.fetch()
        refreshControl.endRefreshing()
    }
}

extension FeedController {

}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60

        return CGSize(width: width, height: height)
    }
}
