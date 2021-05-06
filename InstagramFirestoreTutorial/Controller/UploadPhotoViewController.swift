//
//  UploadPhotoViewController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/07.
//

import UIKit
import SnapKit

class UploadPhotoViewController: UIViewController {

    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let captionTextView: UITextView = {
        let textView: UITextView = UITextView()
        return textView
    }()

    private let characterCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()

    init(photo: UIImage) {
        super.init(nibName: nil, bundle: nil)
        print("selected ", photo)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    // MARK: - Settings for UI
    private func setUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Upload Post"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        setPhotoImageView()
        setCaptionTextView()
        setCharacterCountLabel()
    }

    private func setPhotoImageView() {
        self.view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.height.equalTo(180)
        }
        photoImageView.layer.cornerRadius = 10
    }
    
    private func setCaptionTextView() {
        self.view.addSubview(captionTextView)
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(16)
            make.left.equalTo(self.view.snp.left).offset(12)
            make.right.equalTo(self.view.snp.right).offset(12)
            make.height.equalTo(64)
        }
    }
    
    private func setCharacterCountLabel() {
        self.view.addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints { make in
            make.right.equalTo(self.view.snp.right).offset(-12)
            make.bottom.equalTo(self.captionTextView.snp.bottom)
            make.width.lessThanOrEqualTo(12)
            make.height.greaterThanOrEqualTo(6)
        }
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapDone() {

    }

}
