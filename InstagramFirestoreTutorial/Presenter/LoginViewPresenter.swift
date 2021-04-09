//
//  LoginViewPresenter.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/09.
//

import UIKit

class LoginViewPresenter {
    
    let viewController: UIViewController!
    
    init(sender: UIViewController) {
        self.viewController = sender
    }
    
    private var stackView: UIStackView!
    private let icon: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private(set) var email: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    private(set) var password: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private(set) var login: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("LogIn", for: .normal)
        bt.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        bt.layer.cornerRadius = 5
        bt.clipsToBounds = true
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bt.isEnabled = false
        return bt
    }()
    
    private(set) var signUp: UIButton = {
        let button =  ButtonFactory.button(first: "Don't have an account?  ", second: "Sign up")
        return button
    }()
    
    private let forgotPassword: UIButton = {
        return ButtonFactory.button(first: "Forget your password?  ", second: "Get help signing in.")
    }()
    
    func setUI() {
        viewController.view.backgroundColor = .white
        setGradient()
        setIcon()
        setLoginStackView()
        setSignUp()
        setForgotPassword()
    }
    
    private func setGradient(){
        let bg = BackgroundFactory.background(frame: viewController.view.frame, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor], locations: [0, 1])
        viewController.view.layer.addSublayer(bg)
    }
    
    private func setIcon() {
        viewController.view.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.snp.makeConstraints { make in
            make.centerX.equalTo(viewController.view.snp.centerX)
            make.top.equalTo(viewController.view.safeAreaLayoutGuide).offset(32)
            make.height.equalTo(80)
            make.width.equalTo(120)
        }
    }
    
    private func setLoginStackView() {
        
        viewController.view.addSubview(email)
        viewController.view.addSubview(password)
        viewController.view.addSubview(login)
        
        email.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        password.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        login.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        stackView = UIStackView(arrangedSubviews: [email, password, login])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        viewController.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom)
            make.left.equalTo(viewController.view.snp.left).offset(32)
            make.right.equalTo(viewController.view.snp.right).offset(-32)
        }
    }
    
    private func setSignUp() {
        viewController.view.addSubview(self.signUp)
        self.signUp.translatesAutoresizingMaskIntoConstraints = false
        self.signUp.snp.makeConstraints { make in
            make.centerX.equalTo(viewController.view.snp.centerX)
            make.bottom.equalTo(viewController.view.safeAreaLayoutGuide)
        }
    }
    
    private func setForgotPassword() {
        viewController.view.addSubview(forgotPassword)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        forgotPassword.snp.makeConstraints { make in
            make.centerX.equalTo(viewController.view.snp.centerX)
            make.top.equalTo(stackView.snp.bottom).offset(4)
        }
    }

    

}
