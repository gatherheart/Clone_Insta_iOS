//
//  UploadPhotoViewController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/07.
//

import UIKit
import SnapKit
import RxSwift
import JGProgressHUD

typealias PostData = [String: Any]

protocol UploadPhotoViewControllerDelegate: AnyObject {
    func uploadPhotoViewController(_ controller: UploadPhotoViewController, didFinishUploading data: PostData)
}

class UploadPhotoViewController: UIViewController {
    
    weak var delegate: UploadPhotoViewControllerDelegate?
    //https://stackoverflow.com/questions/25230780/is-it-possible-to-allow-didset-to-be-called-during-initialization-in-swift
    var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    let maxLengthOfTextView: UInt = 100
    let disposeBag: DisposeBag = DisposeBag()
    let progressIndicator: JGProgressHUD = JGProgressHUD(style: .dark)

    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let captionTextView: InputTextView = {
        let textView: InputTextView = InputTextView()
        textView.placeholderText = "Enter caption..."
        textView.font = .systemFont(ofSize: 16)
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
        self.photoImageView.image = photo
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
        captionTextView.textViewDelegate = self
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(16)
            make.left.equalTo(self.view.snp.left).offset(12)
            make.right.equalTo(self.view.snp.right).offset(-12)
            make.height.equalTo(64)
        }
    }
    
    private func setCharacterCountLabel() {
        self.view.addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints { make in
            make.right.equalTo(self.view.snp.right).offset(-12)
            make.bottom.equalTo(self.captionTextView.snp.bottom).offset(8)
            make.height.greaterThanOrEqualTo(6)
        }
        characterCountLabel.adjustsFontSizeToFitWidth = true
        characterCountLabel.minimumScaleFactor = 0.8
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapDone() {
        guard let image = self.photoImageView.image, let caption = captionTextView.text else { return }
        selectedImage = self.photoImageView.image
        var lastData: PostData = PostData()
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: image)
            .subscribe { event in
                switch event {
                case .next(let data):
                    lastData = data
                case .error(let error):
                    InfoLog(error.localizedDescription)
                case .completed:
                    self.delegate?.uploadPhotoViewController(self, didFinishUploading: lastData)
                    self.showLoader(false)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func showLoader(_ show: Bool) {
        view.endEditing(true)
        if show {
            self.progressIndicator.show(in: view)
        } else {
            self.progressIndicator.dismiss()
        }
    }

}

extension UploadPhotoViewController: InputTextViewDelegate {
    func inputTextView(_ didComplete: UITextView) {
    }
    
    private func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > maxLengthOfTextView {
            textView.deleteBackward()
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count: Int = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
