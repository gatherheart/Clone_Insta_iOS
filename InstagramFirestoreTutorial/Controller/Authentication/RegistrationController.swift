//
//  RegistrationController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

class RegistrationController: UIViewController {
    
    private var viewModel: RegistrationViewModel = RegistrationViewModel()
    private var registrationViewPresenter: RegistrationViewPresentable!
    weak var delegate: AuthenticationDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        registrationViewPresenter = RegistrationViewPresenter(sender: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registrationViewPresenter = RegistrationViewPresenter(sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        registrationViewPresenter.present()
    }
    
    private func addTarget() {
        registrationViewPresenter.logIn.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        registrationViewPresenter.plusPhoto.addTarget(self, action: #selector(didTapPlusPhoto), for: .touchUpInside)
        registrationViewPresenter.subViewsInStackView.forEach {
            guard let textField = $0 as? UITextField else { return }
            textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
        registrationViewPresenter.signUp.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    @objc
    private func didTapPlusPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true) { }
    }
    
    @objc
    private func textDidChange(_ sender: UITextField) {
        switch sender {
        case registrationViewPresenter.email:
            viewModel.email = sender.text
        case registrationViewPresenter.password:
            viewModel.password = sender.text
        case registrationViewPresenter.username:
            viewModel.username = sender.text
        case registrationViewPresenter.fullname:
            viewModel.fullname = sender.text
        default:
            break
        }
        registrationViewPresenter.signUp.isEnabled = viewModel.formIsValid
        registrationViewPresenter.signUp.backgroundColor = viewModel.backgroundColor
        registrationViewPresenter.signUp.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
    @objc
    func handleSignUp() {
        guard let email = registrationViewPresenter.email.text else { return }
        guard let password = registrationViewPresenter.password.text else { return }
        guard let fullname = registrationViewPresenter.fullname.text else { return }
        guard let username = registrationViewPresenter.username.text?.lowercased() else { return }
        guard let profileImage = registrationViewPresenter.plusPhoto.imageView?.image else { return }
        

        let credentials = AuthCredentials(email: email, password: password,
                                          fullname: fullname, username: username,
                                          profileImage: profileImage)
        AuthUseCase.register(with: credentials, firestoreManger: FirestoreManager()) { [weak self] result in
            switch result {
            case .success(let user):
                self?.presentSuccessAlert(user["username"] as! String)
            case .failure(let error):
                self?.presentFailureAlert(error)
            }
        }
    }
    
    @objc
    private func goToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    private func presentSuccessAlert(_ user: String) {
        let alert = UIAlertController(title: "Successfully SignedUp", message: "\(user)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in self?.delegate?.didAuthenticationComplete()
        }))
        self.present(alert, animated: true)
    }
    
    private func presentFailureAlert(_ error: Error) {
        let alert = UIAlertController(title: "Failed to register user", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true)
    }
}

extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let seleted = info[.editedImage] as? UIImage else { return }
        registrationViewPresenter.plusPhoto.setImage(seleted.withRenderingMode(.alwaysOriginal), for: .normal)
        registrationViewPresenter.plusPhoto.layer.cornerRadius = registrationViewPresenter.plusPhoto.frame.width / 2
        self.dismiss(animated: true)
    }
}
