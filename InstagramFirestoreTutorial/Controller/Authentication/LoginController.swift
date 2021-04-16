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
        loginViewPresenter.login.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
    }
    
    @objc
    internal func goToSignUp(_ sender: UIButton) {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    internal func login(_ sender: UIButton) {
        guard let email = loginViewPresenter.email.text else { return }
        guard let password = loginViewPresenter.password.text else { return }
        AuthUseCase.login(withEmail: email, password: password) { result, error in
            if let error = error {
                let alert = UIAlertController(title: "Login Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    internal func textDidChange(_ sender: UITextField) {
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
