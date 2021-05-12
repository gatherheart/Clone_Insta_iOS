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

class FeedController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel = PostViewModel()
    let posts = [Post]()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        setupBindings()
        viewModel.fetch()
    }
    
    private func commonInit() {
        navigationItem.title = "Feed"
        setCollectionView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logout))
    }
    
    private func setupBindings() {
        viewModel
            .posts
            .observe(on: MainScheduler.instance)
            .bind(to: self.collectionView.rx.items(cellIdentifier: FeedCollectionViewCell.reuseIdentifier)) { row, post, cell in
                guard let cell: FeedCollectionViewCell = cell as? FeedCollectionViewCell else { return }
                guard let source: URL = URL(string: post.imageUrl) else { return }
                cell.postImage.kf.setImage(with: source)
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
}

extension FeedController: UICollectionViewDelegate {

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
