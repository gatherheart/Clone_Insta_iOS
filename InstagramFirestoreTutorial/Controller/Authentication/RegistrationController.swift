//
//  RegistrationController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit

class RegistrationController: UIViewController {
    
    private var viewModel: RegistrationViewModel = RegistrationViewModel()
    
    private let plusPhoto: UIButton = {
        let button = ButtonFactory.button(backgroundColor: .clear)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapPlusPhoto), for: .touchUpInside)
        return button
    }()

    private let email: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()

    private let password: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()

    private let fullname: CustomTextField = CustomTextField(placeholder: "Fullname")
    private let username: CustomTextField = CustomTextField(placeholder: "Username")

    private let signUp: UIButton = {
        let button = ButtonFactory.button(title: "Sign Up", backgroundColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).withAlphaComponent(0.5), cornerRadius: 5, fontSize: 20)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        return button
    }()

    private let logIn: UIButton = {
        let button = ButtonFactory.button(first: "Already have an account?  ", second: "Login")
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        setGradient()
        view.addSubview(plusPhoto)

        setPlusPhoto()
        setTextFields()
        setLogin()
    }
    
    private func setGradient(){
        let bg = BackgroundFactory.background(frame: self.view.frame, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor], locations: [0, 1])
        self.view.layer.addSublayer(bg)
    }
    
    private func setPlusPhoto() {
        plusPhoto.translatesAutoresizingMaskIntoConstraints = false
        plusPhoto.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(140)
            make.width.equalTo(140)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
        }
     }
    
    private func setTextFields() {
        let subViews = [email, password, fullname, username, signUp]
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-32)
            make.left.equalTo(view.snp.left).offset(32)
            make.top.equalTo(plusPhoto.snp.bottom).offset(32)
        }
        subViews.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            $0.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
    }
    
    private func setLogin() {
        logIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logIn)
        logIn.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
        case email:
            viewModel.email = sender.text
        case password:
            viewModel.password = sender.text
        case username:
            viewModel.username = sender.text
        case fullname:
            viewModel.fullname = sender.text
        default:
            break
        }
        signUp.isEnabled = viewModel.formIsValid
        signUp.backgroundColor = viewModel.backgroundColor
        signUp.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
    @objc
    private func goToLogin() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let seleted = info[.editedImage] as? UIImage else { return }
        plusPhoto.setImage(seleted.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhoto.layer.cornerRadius = plusPhoto.frame.width / 2
        self.dismiss(animated: true)
    }
}
