//
//  AuthenticationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/07.
//

import UIKit


struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
    
    var backgroundColor: UIColor {
        formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        formIsValid ? .white : UIColor(white: 1, alpha: 0.5)
    }
}

struct RegistrationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?

    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var backgroundColor: UIColor {
        formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        formIsValid ? .white : UIColor(white: 1, alpha: 0.5)
    }
}
