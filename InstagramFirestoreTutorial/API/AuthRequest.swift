//
//  AuthRequest.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import UIKit
import FirebaseAuth
import Promises

enum AuthErrors: Error {
    case invalidURL
    case serverError
    case badRequest
    case notFoundUser
}

struct AuthRequest {
    static func register(with: AuthCredentials) -> Promise<String> {
        return Promise { fulfill, reject in
            Auth.auth().createUser(withEmail: with.email, password: with.password) { (result, error) in
                if let error = error {
                    print("DEBUG ERROR: Register failure \(String(describing: error.localizedDescription))")
                    reject(error)
                }
                guard let uid = result?.user.uid else { reject(AuthErrors.badRequest); return }
                fulfill(uid)
            }
        }
    }
    
    static func checkLoggedIn() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    static func login(withEmail email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func logout() -> Promise<Void> {
        return Promise { fulfill, reject in
            do {
                try Auth.auth().signOut()
                fulfill(())
            } catch let error {
                reject(error)
            }
        }
    }
}
