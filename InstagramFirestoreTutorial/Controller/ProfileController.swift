//
//  ProfileController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit
import Dwifft

class ProfileController: UIViewController {
    
    var user: User?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    var stuff: SectionedValues<String, String> = Stuff.userStuff() {
        didSet {
            self.diffCalculator?.sectionedValues = stuff
        }
    }
    var diffCalculator: CollectionViewDiffCalculator<String, String>?

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diffCalculator = CollectionViewDiffCalculator(collectionView: collectionView, initialSectionedValues: self.stuff)
        checkFollow()
        fetchUserStats()
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
    }
    
    private func commonInit() {
        navigationItem.title = "Profile"
        collectionView.delegate = self
        collectionView.dataSource = self
        setCollectionView()
    }
    
    private func setCollectionView() {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseIdentifier)
        self.view.addSubview(collectionView)
    }
    
    // MARK: - API
    private func fetchUser() {
        UserService.fetchUser().then { user in
            print(user)
            self.user = user
            self.navigationItem.title = user.username
        }.catch { error in
            print(error)
        }
    }
    
    private func checkFollow() {
        guard let userId = user?.uid else { return }
        UserService.isFollowed(uid: userId)
            .then { isFollowed in
                self.user?.isFollowed = isFollowed
                self.collectionView.reloadData()
            }
    }
    
    private func fetchUserStats() {
        guard let userId = user?.uid else { return }
        UserService.fetchUserStats(uid: userId)
            .then { userStats in
                self.user?.stats = userStats
                self.collectionView.reloadData()
            }
    }
}

extension ProfileController: UICollectionViewDelegate {

}


extension ProfileController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let diffCalculator = diffCalculator else { return 0 }
        return diffCalculator.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let diffCalculator = self.diffCalculator else { return 0 }
        return diffCalculator.numberOfObjects(inSection: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        guard let diffCalculator = self.diffCalculator else { return cell }
        let thing = diffCalculator.value(atIndexPath: indexPath)
        cell.label.text = thing
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.reuseIdentifier, for: indexPath) as? ProfileHeader else { return UICollectionReusableView() }
            if let user = user {
                header.viewModel = ProfileHeaderViewModel(user: user)
            }
            header.delegate = self
            return header
        default:
        return UICollectionReusableView()
        }
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isMe {
            print("\(user) is me")
        }
        else if user.isFollowed {
            UserService.unfollow(uid: user.uid)
                .then(on: DispatchQueue.main) { [weak self] result in
                    guard let self = self, result == true else { return }
                    self.user?.isFollowed = false
                    self.collectionView.reloadData()
            }
        }
        else {
            UserService.follow(uid: user.uid)
                .then(on: DispatchQueue.main) { [weak self] result in
                    guard let self = self, result == true else { return }
                    self.user?.isFollowed = true
                    self.collectionView.reloadData()
            }
        }
    }
    func shuffle() {
        self.stuff = Stuff.userStuff()
    }
}
