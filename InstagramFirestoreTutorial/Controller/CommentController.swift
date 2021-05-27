//
//  CommentController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/25.
//

import UIKit

class CommentController: UICollectionViewController {
    
    private var post: Post?
    private var comments: [Comment] = []
    private var commentInputView: CommentInputAccesoryView = {
        let frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        let inputView: CommentInputAccesoryView = CommentInputAccesoryView(frame: frame)
        return inputView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return commentInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    init(post: Post) {
        self.post = post
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        super.init(collectionViewLayout: layout)
        commonInit()
    }
    
    override init(collectionViewLayout: UICollectionViewLayout) {
        super.init(collectionViewLayout: collectionViewLayout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.setCollectionView()
        self.collectionView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.keyboardDismissMode = .onDrag
        collectionView.alwaysBounceVertical = true
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setCollectionView() {
        self.navigationItem.title = "Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
    }
    
    private func fetchComments() {
        guard let post = post else { return }
        CommentService.fetchComments(forPost: post.postId).then { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }

}

extension CommentController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension CommentController: UICollectionViewDelegateFlowLayout {
}
