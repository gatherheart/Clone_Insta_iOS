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
    private var loginViewPresenter: LoginViewPresentable!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loginViewPresenter = LoginViewPresenter(sender: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loginViewPresenter = LoginViewPresenter(sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addTarget()
        loginViewPresenter.present()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    

}

extension LoginController {
    
    func addTarget() {
        loginViewPresenter.email.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        loginViewPresenter.password.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        loginViewPresenter.signUp.addTarget(self, action: #selector(goToSignUp(_:)), for: .touchUpInside)
    }
    
    @objc
    internal func goToSignUp(_ sender: UIButton) {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc internal func textDidChange(_ sender: UITextField) {
        switch sender {
        case loginViewPresenter.email:
            viewModel.email = sender.text
        case loginViewPresenter.password:
            viewModel.password = sender.text
        default:
            break
        }
        loginViewPresenter.login.isEnabled = viewModel.formIsValid
        loginViewPresenter.login.backgroundColor = viewModel.backgroundColor
        loginViewPresenter.login.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
}
