//
//  RegistrationViewPresenter.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/10.
//

import UIKit

protocol RegistrationViewPresentable {
    var plusPhoto: UIButton { get }
    var email: CustomTextField { get }
    var password: CustomTextField { get }
    var fullname: CustomTextField { get }
    var username: CustomTextField { get }
    var signUp: UIButton { get }
    var logIn: UIButton { get }
    var stackView: UIStackView { get }
    var subViewsInStackView: [UIView] { get }
    func present()
}

class RegistrationViewPresenter: RegistrationViewPresentable {
    
    let viewController: UIViewController!
    
    init(sender: UIViewController) {
        self.viewController = sender
        self.subViewsInStackView = [email, password, fullname, username, signUp]
    }
    
    // MARK: - UI Components
    
    private(set) var plusPhoto: UIButton = {
        let button = ButtonFactory.button(backgroundColor: .clear)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        return button
    }()

    private(set) var email: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()

    private(set) var password: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()

    private(set) var fullname: CustomTextField = CustomTextField(placeholder: "Fullname")
    private(set) var username: CustomTextField = CustomTextField(placeholder: "Username")

    private(set) var signUp: UIButton = {
        let button = ButtonFactory.button(title: "Sign Up", backgroundColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).withAlphaComponent(0.5), cornerRadius: 5, fontSize: 20)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        return button
    }()

    private(set) var logIn: UIButton = {
        let button = ButtonFactory.button(first: "Already have an account?  ", second: "Login")
        return button
    }()
    
    private(set) var stackView = UIStackView()
    private(set) var subViewsInStackView = [UIView]()

    func present() {
        viewController.view.backgroundColor = .white
        presentGradients()
        viewController.view.addSubview(plusPhoto)

        presentPlusPhoto()
        presentTextFields()
        presentLogin()
    }
    
    private func presentGradients(){
        let bg = BackgroundFactory.background(frame: viewController.view.frame, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor], locations: [0, 1])
        viewController.view.layer.addSublayer(bg)
    }
    
    private func presentPlusPhoto() {
        plusPhoto.translatesAutoresizingMaskIntoConstraints = false
        plusPhoto.snp.makeConstraints { make in
            make.centerX.equalTo(viewController.view.snp.centerX)
            make.height.equalTo(140)
            make.width.equalTo(140)
            make.top.equalTo(viewController.view.safeAreaLayoutGuide).offset(32)
        }
     }
    
    private func presentTextFields() {
        stackView = UIStackView(arrangedSubviews: subViewsInStackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.right.equalTo(viewController.view.snp.right).offset(-32)
            make.left.equalTo(viewController.view.snp.left).offset(32)
            make.top.equalTo(plusPhoto.snp.bottom).offset(32)
        }
        subViewsInStackView.forEach {
            guard let textField = $0 as? UITextField else { return }
            textField.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
    
    private func presentLogin() {
        logIn.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(logIn)
        logIn.snp.makeConstraints { make in
            make.centerX.equalTo(viewController.view.snp.centerX)
            make.bottom.equalTo(viewController.view.safeAreaLayoutGuide)
        }
    }
    
}
