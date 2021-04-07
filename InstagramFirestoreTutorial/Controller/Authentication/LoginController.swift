//
//  LoginController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    
    private var viewModel:LoginViewModel = LoginViewModel()
    private var stackView: UIStackView!
    private let icon: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let email: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    private let password: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let login: UIButton = {
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
    private let singUp: UIButton = {
        let button =  ButtonFactory.button(first: "Don't have an account?  ", second: "Sign up")
        button.addTarget(self, action: #selector(goToSignUp(_:)), for: .touchUpInside)
        return button
    }()
    private let forgotPassword: UIButton = {
        return ButtonFactory.button(first: "Forget your password?  ", second: "Get help signing in.")
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setUI() {
        view.backgroundColor = .white

        setGradient()
        setIcon()
        setLoginStackView()
        setSignUp()
        setForgotPassword()
    }
    
    private func setGradient(){
        let bg = BackgroundFactory.background(frame: self.view.frame, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor], locations: [0, 1])
        self.view.layer.addSublayer(bg)
    }
    
    private func setIcon() {
        view.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.height.equalTo(80)
            make.width.equalTo(120)
        }
    }
    
    private func setLoginStackView() {
        
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(login)
        
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
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom)
            make.left.equalTo(self.view.snp.left).offset(32)
            make.right.equalTo(self.view.snp.right).offset(-32)
        }
        
        email.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)

    }
    
    private func setSignUp() {
        view.addSubview(singUp)
        singUp.translatesAutoresizingMaskIntoConstraints = false
        singUp.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setForgotPassword() {
        view.addSubview(forgotPassword)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        forgotPassword.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(stackView.snp.bottom).offset(4)
        }
    }
    
    @objc
    private func goToSignUp(_ sender: UIButton) {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        switch sender {
        case email:
            viewModel.email = sender.text
        case password:
            viewModel.password = sender.text
        default:
            break
        }
        login.isEnabled = viewModel.formIsValid
        login.backgroundColor = viewModel.backgroundColor
        login.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}
