//
//  AuthRequest.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/13.
//

import UIKit
import FirebaseAuth

enum AuthErrors: Error {
    case invalidURL
    case serverError
    case badRequest
}

struct AuthRequest {
    static func register(with: AuthCredentials, completion: @escaping (Result<String, AuthErrors>?) -> Void) {
        Auth.auth().createUser(withEmail: with.email, password: with.password) { (result, error) in
            if let error = error {
                print("DEBUG ERROR: Register failure \(String(describing: error.localizedDescription))")
                completion(.failure(.badRequest))
                return
            }
            guard let uid = result?.user.uid else { completion(.failure(.badRequest)); return }
            completion(.success(uid))
        }
    }
    
    static func checkLoggedIn() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    static func login(withEmail email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func logout(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
